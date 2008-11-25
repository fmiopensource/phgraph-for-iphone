//
//  PHGraphView.m
//  Graph
//
//  Created by Pierre-Henri Jondot on 30/03/08.
//  Ported to iPhone by brian@fluidmedia.com 08-2008
//

#import "PHGraphView.h"

@implementation PHGraphView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		xAxis = [[NSMutableArray alloc] init];
		yAxis = [[NSMutableArray alloc] init];
		graphObjects = [[NSMutableArray alloc] init];
		hasBorder = YES;
		leftBorder = 20;
		rightBorder = 20;
		bottomBorder = 0;
		topBorder = 125;
	}
    return self;
}

-(void)dealloc
{
	[xAxis release];
	[yAxis release];
	[graphObjects release];
	[super dealloc];
}

-(void)addPHxAxis:(PHxAxis*)axis
{
	[xAxis addObject:axis];
}

-(void)addPHyAxis:(PHyAxis*)axis
{
	[yAxis addObject:axis];
}

-(void)addPHGraphObject:(PHGraphObject*)object 
{
	[graphObjects addObject:object];
}

-(void)removePHxAxis:(PHxAxis*)axis
{
	[xAxis removeObject:axis];
}

-(void)removePHyAxis:(PHyAxis*)axis
{
	[yAxis removeObject:axis];
}

-(void)removePHGraphObject:(PHGraphObject*)object
{
	[graphObjects removeObject:object];
}

//direct accessors to the arrays of axis and objects
-(NSMutableArray*)xAxisMutableArray
{
	return xAxis;
}

-(NSMutableArray*)yAxisMutableArray
{
	return yAxis;
}

-(NSMutableArray*)graphObjectsMutableArray
{
	return graphObjects;
}

-(void)setXAxisMutableArray:(NSMutableArray*)anArray
{
	[anArray retain];
	[xAxis release];
	xAxis = anArray;
}

-(void)setYAxisMutableArray:(NSMutableArray*)anArray
{
	[anArray retain];
	[yAxis release];
	yAxis = anArray;
}

-(void)setGraphObjectsMutableArray:(NSMutableArray*)anArray
{
	[anArray retain];
	[graphObjects release];
	graphObjects = anArray;
}

-(void)setHasBorder:(BOOL)value
{
	hasBorder = value;
}

-(void)setLeftBorder:(float)newLeftBorder rightBorder:(float)newRightBorder
		bottomBorder:(float)newBottomBorder topBorder:(float)newTopBorder
{
	leftBorder = newLeftBorder;
	rightBorder = newRightBorder;
	bottomBorder = newBottomBorder;
	topBorder = newTopBorder;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGRect arect = [self frame];
	CGRect clippingArea = CGRectMake(arect.origin.x, arect.origin.y, arect.size.width, arect.size.height);
	if (hasBorder) {
		clippingArea.origin.x += leftBorder;
		clippingArea.origin.y += bottomBorder;
		clippingArea.size.width -= leftBorder+rightBorder;
		clippingArea.size.height -= bottomBorder+topBorder;
	}
	CGRect drawingArea = CGRectMake(clippingArea.origin.x, clippingArea.origin.y, clippingArea.size.width, clippingArea.size.height);
	int n = [graphObjects count], i;
	for (i=0; i<n; i++)
	{
		PHGraphObject *object=(PHGraphObject*)[graphObjects objectAtIndex:i];
		if (([object shouldDraw]) && (!([object isLongToDraw])))
		{
			CGContextSaveGState(context);
			if (hasBorder) CGContextClipToRect(context,clippingArea);
			[[graphObjects objectAtIndex:i] drawWithContext:context rect:drawingArea];
			CGContextRestoreGState(context);
		}
	}
	n=[xAxis count];
	for (i=0; i<n; i++)
	{
		PHxAxis* axis = [xAxis objectAtIndex:i];
		[axis setDrawOutside:hasBorder];
		[axis drawWithContext:context rect:drawingArea];
	}
	n=[yAxis count];
	for (i=0; i<n; i++)
	{
		PHyAxis* axis = [yAxis objectAtIndex:i];
		[axis setDrawOutside:hasBorder];
		[axis drawWithContext:context rect:drawingArea];
	}
	CGContextFlush(context);
}
@end
