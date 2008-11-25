//
//  PHGraphObject.m
//  Graph
//
//  Created by Pierre-Henri Jondot on 01/04/08.
//  Ported to iPhone by brian@fluidmedia.com 08-2008
//

#import "PHGraphObject.h"


@implementation PHGraphObject
-(void)drawWithContext:(CGContextRef)context rect:(CGRect)rect
{}

-(id)initWithXAxis:(PHxAxis *)aPHxAxis yAxis:(PHyAxis *)aPHyAxis
{
	[super init];
	[aPHxAxis retain];
	[xAxis release];
	xAxis=aPHxAxis;
	[aPHyAxis retain];
	[yAxis release];
	yAxis=aPHyAxis;
	shouldDraw = YES;
	return self;
}

-(void)setXAxis:(PHxAxis *)aPHxAxis
{
	[aPHxAxis retain];
	[xAxis release];
	xAxis = aPHxAxis;
}

-(void)setYAxis:(PHyAxis *)aPHyAxis
{
	[aPHyAxis retain];
	[yAxis release];
	yAxis = aPHyAxis;
}

-(void)dealloc
{
	[xAxis release];
	[yAxis release];
	[super dealloc];
}

-(BOOL)isLongToDraw
{
	return NO;
}

-(BOOL)shouldDraw
{
	return shouldDraw;
}

-(void)setShouldDraw:(BOOL)flag
{
	shouldDraw = flag;
}

@end
