//
//  PHAxis.m
//  Graph
//
//  Created by Pierre-Henri Jondot on 30/03/08.
//  Ported to iPhone by brian@fluidmedia.com 08-2008
//

#import "PHAxis.h"
@implementation PHAxis

@synthesize tickValues;

-(id)init
{
	[super init];
	minimum=-3;
	maximum=3;
	[self setColor:[UIColor whiteColor]];
	style=0;
	width=1.0;
	majorTickWidth=1;
	predefinedMajorTickWidth=YES;
	minorTicksNumber=0;
	return self;
}

-(id)initWithStyle:(int)the_style
{
	[self init];
	style=the_style;
	return self;
}

-(void)dealloc
{
	[cocoaColor release];
	[super dealloc];
}

-(void)setColor:(UIColor*)newColor
{
	[newColor retain];
	[cocoaColor release];
	cocoaColor = newColor;
}

-(UIColor*)color
{
	return cocoaColor;
}

-(void)setStyle:(int)newStyle
{
	style = newStyle;
}

-(int)style
{
	return style;
}

-(void)setMinimum:(double)newMinimum maximum:(double)newMaximum
{
	if (newMaximum>newMinimum)
	{
		minimum = newMinimum;
		maximum = newMaximum;
		[self calculateMajorTickWidth];
	}
}

-(double)convertValue:(float)x
{
	if (style & PHIsLog)
		{return pow(10,minimum+(double)x*(maximum-minimum));}
	return minimum+(double)x*(maximum-minimum);
}

-(void)saveValues
{
	minimumRetained = minimum; 
	maximumRetained = maximum;
}

-(void)setMajorTickWidth:(double)newValue
{
	predefinedMajorTickWidth = YES;
	majorTickWidth = newValue;
}

-(void)unsetMajorTickWidth
{
	predefinedMajorTickWidth = NO;
}

-(void)calculateMajorTickWidth
{
	if (!predefinedMajorTickWidth) 
	{
		double logWidth = log10(maximum-minimum);
		double expPart = pow(10,floor(logWidth));
		logWidth -= floor(logWidth);

		if (style & PHSmall)
		{
			double mantissePart = 2;
			if (logWidth<log10(2)) mantissePart = 0.5; else
				if (logWidth<log10(5)) mantissePart = 1;
			majorTickWidth = mantissePart*expPart;
			return;
		}
		if (style & PHBig)
		{
			double mantissePart = 0.5;
			if (logWidth<log10(2)) mantissePart = 0.1; else
				if (logWidth<log10(5)) mantissePart = 0.2;
			majorTickWidth = mantissePart*expPart;
			return;
		}
		double mantissePart = 1;
		if (logWidth<log10(2)) mantissePart = 0.2; else
			if (logWidth<log10(5)) mantissePart = 0.5;
		majorTickWidth = mantissePart*expPart;
	} 
}

-(double)majorTickWidth
{
	return majorTickWidth;
}

-(void)setMinorTicksNumber:(int)newValue
{
	minorTicksNumber = newValue;
}

-(NSMutableArray*)majorTickMarks
{
	NSMutableArray* TickMarks=[NSMutableArray array];
	if (!(style & PHIsLog))
	{
		double Tick;
		for (Tick=majorTickWidth*ceil(minimum/majorTickWidth); Tick<maximum+(maximum-minimum)*PHEPSILON; 
			Tick+=majorTickWidth)
				[TickMarks addObject:[NSNumber numberWithDouble:Tick]];
		return TickMarks;
	} else
	{
		//Logarithmic scale : two possibilities according to the maximum/minimum factor... If this one
		// is smaller than 100, we revert to non-logarithmic scale algorithm  
		if (maximum-minimum<2)
		{
			double minimumSave = minimum;
			double maximumSave = maximum;
			minimum=pow(10,minimum); 
			maximum=pow(10,maximum);
			[self calculateMajorTickWidth];
			double Tick;
			for (Tick=majorTickWidth*ceil(minimum/majorTickWidth); Tick<maximum+(maximum-minimum)*PHEPSILON;
				Tick+=majorTickWidth)
					[TickMarks addObject:[NSNumber numberWithDouble:log10(Tick)]];
			minimum = minimumSave;
			maximum = maximumSave;
			return TickMarks;
		}
// TODO : this part will draw too many Tickpoints when the interval is very large (maximum/minimum>10e10)
/*		if (maximum-minimum<10)
		{*/
			double Tick;
			for (Tick=ceil(minimum); Tick<maximum+(maximum-minimum)*PHEPSILON; Tick+=1)
				[TickMarks addObject:[NSNumber numberWithDouble:Tick]];
			return TickMarks;
/*		}
		if (maximum-minimum<50)
		{
			double Tick;
			for (Tick=5*(ceil(minimum/5)); Tick<maximum+(maximum-minimum)*PHEPSILON; Tick+=5)
				[TickMarks addObject:[NSNumber numberWithDouble:Tick]];
			return TickMarks;
		}
		double Tick;
		for (Tick=10*(ceil(minimum/10)); Tick<maximum+(maximum-minimum)*PHEPSILON; Tick+=10);
			[TickMarks addObject:[NSNumber numberWithDouble:Tick]];
		return TickMarks;*/
	}
}

-(NSMutableArray*)minorTickMarks
{
	NSMutableArray* TickMarks = [NSMutableArray array];
	if (!(style & PHIsLog))
	{
		int nextMajorTickIn = 
			minorTicksNumber*ceil(minimum/majorTickWidth)-ceil(minorTicksNumber*minimum/majorTickWidth);
	
		double Tick;
		for (Tick=majorTickWidth/minorTicksNumber*ceil(minorTicksNumber*minimum/majorTickWidth);
			Tick<maximum; Tick+=majorTickWidth/minorTicksNumber)
		{
			if (nextMajorTickIn-- == 0)
			{
				nextMajorTickIn = minorTicksNumber-1;
			} else
			{
				[TickMarks addObject:[NSNumber numberWithDouble:Tick]];
			}
		}
		return TickMarks;
	}
	else {
		if (maximum-minimum<2)
		{
			double minimumSave = minimum;
			double maximumSave = maximum;
			minimum=pow(10,minimum);
			maximum=pow(10,maximum);
			
			[self calculateMajorTickWidth];
		
			int nextMajorTickIn = 
				minorTicksNumber*ceil(minimum/majorTickWidth)-ceil(minorTicksNumber*minimum/majorTickWidth);
			double Tick;
			for (Tick=majorTickWidth/minorTicksNumber*ceil(minorTicksNumber*minimum/majorTickWidth);
				Tick<maximum; Tick+=majorTickWidth/minorTicksNumber)
			{
				if (nextMajorTickIn-- == 0)
				{
					nextMajorTickIn = minorTicksNumber-1;
				} else
				{
					[TickMarks addObject:[NSNumber numberWithDouble:log10(Tick)]];
				}
			}
			minimum = minimumSave;
			maximum = maximumSave;
			return TickMarks;
		}
		//TODO : same as majorTickMarks
		int i = floor(minimum), j;
		for (j=2; j<10; j++)
			if (i+log10(j)>minimum) [TickMarks addObject:[NSNumber numberWithDouble:i+log10(j)]];
		for (++i; i<floor(maximum);i++)
			for (j=2; j<10; j++)
				[TickMarks addObject:[NSNumber numberWithDouble:i+log10(j)]];
		for (j=0; j<10; j++)
			if (i+log10(j)<maximum) [TickMarks addObject:[NSNumber numberWithDouble:i+log10(j)]];
		return TickMarks;
	};
}

-(double)minimum
{
	return minimum;
}

-(double)maximum
{
	return maximum;
}

-(void)setDrawOutside:(BOOL)value
{
	drawOutside = value;
}
@end
