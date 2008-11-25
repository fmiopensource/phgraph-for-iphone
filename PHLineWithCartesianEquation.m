//
//  PHLineWithCartesianEquation.m
//  PHGraph
//
//  Created by Pierre-Henri Jondot on 12/04/08.
//  Ported to iPhone by brian@fluidmedia.com 08-2008
//

#import "PHLineWithCartesianEquation.h"
//#import "PHColor.h"

@implementation PHLineWithCartesianEquation

-(id)initWithXAxis:(PHxAxis*)aPHxAxis yAxis:(PHyAxis*)aPHyAxis a:(double)aValue b:(double)bValue
		c:(double)cValue
{
	[(PHGraphObject*)super initWithXAxis:aPHxAxis yAxis:aPHyAxis];
	a = aValue;
	b = bValue;
	c = cValue;
	style = PHStraight;
	width = 1;
	cocoaColor = [[UIColor blueColor] retain];
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
		
-(void)setEquationA:(double)aValue b:(double)bValue c:(double)cValue
{
	a = aValue;
	b = bValue;
	c = cValue;
}

-(void)setWidth:(float)newWidth
{
	width = newWidth;
}

-(void)setStyle:(int)newStyle
{
	style = newStyle;
}

-(void)drawWithContext:(CGContextRef)context rect:(NSRect)rect
{
	CGColorRef color = cocoaColor.CGColor;
	CGContextSetStrokeColorWithColor(context, color);
	CGContextSetLineWidth(context, width);
	double xmin = [xAxis minimum];
	double xmax = [xAxis maximum];
	double ymin = [yAxis minimum];
	double ymax = [yAxis maximum];
	
	if ([xAxis style] & PHIsLog)
	{
		xmin = pow(10,xmin);
		xmax = pow(10,xmax);
	}
	if ([yAxis style] & PHIsLog)
	{
		ymin = pow(10,ymin);
		ymax = pow(10,ymax);
	}
	
	CGContextBeginPath(context);
	switch (style) {
		case PHDashed33:
		{
			float dash[2] = {3,3};
			CGContextSetLineDash(context,0,dash,2); 
		}
		break;
	
		case PHDashed8212:
		{
			float dash[4] = {8,2,1,2};
			CGContextSetLineDash(context,0,dash,4); 
		}
		break;
	}
	
	BOOL intersectBorder = NO;
	
	if ((a*xmin+b*ymin+c)*(a*xmin+b*ymax+c)<0)
	{
		intersectBorder = YES;
		float x = rect.origin.x;
		float y = (rect.size.height+rect.origin.y)-(a*xmin+b*ymin+c)/(b*(ymin-ymax))*rect.size.height;
		
		CGContextMoveToPoint(context, x, y);
	}
	
	if ((a*xmin+b*ymax+c)*(a*xmax+b*ymax+c)<0)
	{
		float x = rect.origin.x + (a*xmin+b*ymax+c)/(a*(xmin-xmax))*rect.size.width;
		float y = (rect.size.height+rect.origin.y)-rect.size.height;
		
		if (intersectBorder)
		{
			CGContextAddLineToPoint(context, x, y);
			CGContextStrokePath(context);
			return;
		} else
		{
			intersectBorder = YES;
			CGContextMoveToPoint(context, x, y);
		}
	}
	
	if ((a*xmax+b*ymax+c)*(a*xmax+b*ymin+c)<0)
	{
		float x = rect.origin.x+rect.size.width;
		float y = (rect.size.height+rect.origin.y)-(a*xmax+b*ymin+c)/(b*(ymin-ymax))*rect.size.height;
		
		if (intersectBorder)
		{
			CGContextAddLineToPoint(context, x, y);
			CGContextStrokePath(context);
			return;
		} else
		{
			intersectBorder = YES;
			CGContextMoveToPoint(context, x, y);
		}
	}
	if ((a*xmax+b*ymin+c)*(a*xmin+b*ymin+c)<0)
	{
		float x = rect.origin.x+(a*xmin+b*ymin+c)/(a*(xmin-xmax))*rect.size.width;
		float y = (rect.size.height+rect.origin.y);
		
		if (intersectBorder)
		{
			CGContextAddLineToPoint(context, x, y);
			CGContextStrokePath(context);
		}
	}
}

@end
