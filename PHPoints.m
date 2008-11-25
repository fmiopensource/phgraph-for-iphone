//
//  PHPoints.m
//  Graph
//
//  Created by Pierre-Henri Jondot on 01/04/08.
//  Ported to iPhone by brian@fluidmedia.com 08-2008
//

#import "PHPoints.h"

@implementation PHPoints
-(id)initWithXData:(double*)xd yData:(double*)yd numberOfPoints:(int)np
		xAxis:(PHxAxis*)xaxis yAxis:(PHyAxis*)yaxis
{
	[super initWithXAxis:xaxis yAxis:yaxis];
	xData = xd;
	yData = yd;
	numberOfPoints = np;
	size = 0.5;
	width = 0.5;
	style = PHCircle;
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

-(void)setSize:(float)newSize
{
	size = newSize;
}

-(void)setWidth:(float)newWidth
{
	width = newWidth;
}

-(void)setStyle:(int)newStyle
{
	style = newStyle;
}

-(void)setNumberOfPoints:(int)newNumberOfPoints
{	
	numberOfPoints = newNumberOfPoints;
}

-(void)drawWithContext:(CGContextRef)context rect:(CGRect)rect
{
	CGColorRef color = cocoaColor.CGColor;
	CGContextSetStrokeColorWithColor(context, color);
	CGContextSetFillColorWithColor(context, color);
	CGContextSetLineWidth(context, width);
	CGContextBeginPath(context);
	
	double xmin = [xAxis minimum];
	double xmax = [xAxis maximum];
	double ymin = [yAxis minimum];
	double ymax = [yAxis maximum];
	int i;
	int pointsInPath = 0;
	int isXlog = [xAxis style] & PHIsLog;
	int isYlog = [yAxis style] & PHIsLog;
	double xc, yc;
	
	for (i=0; i<numberOfPoints;i++)
	{
		xc = isXlog ? log10(xData[i]) : xData[i]; 
		yc = isYlog ? log10(yData[i]) : yData[i];
		
		if ((xc>=xmin) && (xc<=xmax) && (yc>=ymin) && (yc<=ymax))
		{
			float x = rect.origin.x+rect.size.width*(xc-xmin)/(xmax-xmin);
			//float y = rect.origin.y+rect.size.height*(yc-ymin)/(ymax-ymin);
			float y =(rect.size.height+rect.origin.y)-rect.size.height*(yc-ymin)/(ymax-ymin);
			
			if (style & PHCrossx)
			{
				CGContextMoveToPoint(context, x-size, y-size);
				CGContextAddLineToPoint(context, x+size,y+size);
				CGContextMoveToPoint(context, x-size,y+size);
				CGContextAddLineToPoint(context,x+size,y-size);
			}
			
			if (style & PHCrossplus)
			{
				CGContextMoveToPoint(context, x-size, y);
				CGContextAddLineToPoint(context, x+size,y);
				CGContextMoveToPoint(context, x,y-size);
				CGContextAddLineToPoint(context,x,y+size);
			}
			
			if (style & PHCircle)
			{
				CGContextMoveToPoint(context, x-size, y);
				CGContextAddEllipseInRect(context, CGRectMake(x-size,y-size,2*size,2*size));	
			}
			
			if (style & PHDiamond)
			{
				CGContextMoveToPoint(context, x-size, y);
				CGContextAddLineToPoint(context, x, y+size);
				CGContextAddLineToPoint(context, x+size, y);
				CGContextAddLineToPoint(context, x, y-size);
				CGContextAddLineToPoint(context, x-size, y);
			}
			
			if (++pointsInPath==1000) {
				CGContextStrokePath(context);
				pointsInPath = 0;
			}
		}
	}
	if (pointsInPath)
		CGContextStrokePath(context);
}
@end
