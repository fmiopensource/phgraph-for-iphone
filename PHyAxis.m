//
//  PHyAxis.m
//  Graph
//
//  Created by Pierre-Henri Jondot on 01/04/08.
//  Ported to iPhone by brian@fluidmedia.com 08-2008
//

#import "PHyAxis.h"

@implementation PHyAxis
-(void)drawWithContext:(CGContextRef)context rect:(CGRect)rect
{
	if (style==0) { return;}
	CGColorRef color = cocoaColor.CGColor;
	NSMutableArray *ticks;
	CGContextSetStrokeColorWithColor(context, color);
	CGContextSetFillColorWithColor(context, color);
	CGContextBeginPath(context);
	int j;
	float wmajor=0.4, wminor=0.1;
	ticks = [[self majorTickMarks] retain];
	
	UIFont *font = [UIFont systemFontOfSize:8];
	
	if (style & PHShowGrid)
	{
		CGContextSetLineWidth(context, wmajor);
		for (j=0; j < [ticks count]; j++)
		{
			double yf = [[ticks objectAtIndex:j] doubleValue];
			CGFloat y = rect.origin.y+(yf-minimum)/(maximum-minimum)*rect.size.height;
			CGContextMoveToPoint(context, rect.origin.x,y);
			CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, y);
		}
		CGContextStrokePath(context);
	}
	if (style & PHShowGraduationAtLeft)
	{
		CGContextSetLineWidth(context, width);
		CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
		CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y+rect.size.height);
		for (j=0; j< [ticks count]; j++)
		{
			double yf = [[ticks objectAtIndex:j] doubleValue];
			//CGFloat y = rect.origin.y+(yf-minimum)/(maximum-minimum)*rect.size.height;
			CGFloat y = (rect.size.height+rect.origin.y)-(yf-minimum)/(maximum-minimum)*rect.size.height;
			CGContextMoveToPoint(context, rect.origin.x,y);
			if (drawOutside) {
				CGContextAddLineToPoint(context, rect.origin.x-5, y);
			} else {
				CGContextAddLineToPoint(context, rect.origin.x+5, y);
			}
			NSString *value;
			if (!(PHIsLog & style))
			{
				if (fabs(yf/majorTickWidth)<0.5)
				{ value = @"0"; } else
				{ value = [NSString stringWithFormat:@"%1.4lg",yf]; } 
			} else
				value = [NSString stringWithFormat:@"%1.4lg",pow(10,yf)];
			if (drawOutside) {
				[value drawAtPoint:CGPointMake(rect.origin.x-7,y+1) withFont:font];
			} else {
				[value drawAtPoint:CGPointMake(rect.origin.x+7,y+1) withFont:font];
			}
			
		}
		CGContextStrokePath(context);
	}
	if (style & PHShowGraduationAtRight)
	{
		CGContextSetLineWidth(context, width);
		CGContextMoveToPoint(context, rect.origin.x+rect.size.width, rect.origin.y);
		CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
		for (j=0; j < [ticks count]; j++)
		{
			double yf = [[ticks objectAtIndex:j] doubleValue];
			//CGFloat y = rect.origin.y+(yf-minimum)/(maximum-minimum)*rect.size.height;
			CGFloat y = (rect.size.height+rect.origin.y)-(yf-minimum)/(maximum-minimum)*rect.size.height;
			CGContextMoveToPoint(context, rect.origin.x+rect.size.width,y);
			if (drawOutside) {
				CGContextAddLineToPoint(context, rect.origin.x+rect.size.width+5, y);
			} else {
				CGContextAddLineToPoint(context, rect.origin.x+rect.size.width-5, y);
			}
			NSString *value;
			if (!(PHIsLog & style))
			{
				if (fabs(yf/majorTickWidth)<0.5)
				{ value = @"0"; } else
				{ value = [NSString stringWithFormat:@"%1.4lg",yf]; } 
			} else
				value = [NSString stringWithFormat:@"%1.4lg",pow(10,yf)];
			
			if (drawOutside) {
				[value drawAtPoint:CGPointMake(rect.origin.x+rect.size.width+7,y+1) withFont:font];
			} else {
				[value drawAtPoint:CGPointMake(rect.origin.x+rect.size.width-7,y+1) withFont:font];
			}
		}
		CGContextStrokePath(context);
	}
	[ticks release];
	ticks = [[self minorTickMarks] retain];
	if (style & PHShowGrid)
	{
		CGContextSetLineWidth(context, wminor);
		for (j=0; j< [ticks count]; j++)
		{
			double yf = [[ticks objectAtIndex:j] doubleValue];
			CGFloat y = rect.origin.y+(yf-minimum)/(maximum-minimum)*rect.size.height;
			CGContextMoveToPoint(context, rect.origin.x,y);
			CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, y);
		}
		CGContextStrokePath(context);
	}
	if (style & PHShowGraduationAtLeft)
	{
		CGContextSetLineWidth(context, width*0.5);
		for (j=0; j< [ticks count]; j++)
		{
			double yf = [[ticks objectAtIndex:j] doubleValue];
			CGFloat y = rect.origin.y+(yf-minimum)/(maximum-minimum)*rect.size.height;
			CGContextMoveToPoint(context, rect.origin.x,y);
			if (drawOutside) {
				CGContextAddLineToPoint(context, rect.origin.x-3, y);
			} else {
				CGContextAddLineToPoint(context, rect.origin.x+3, y);
			}
		}
		CGContextStrokePath(context);
	}
	if (style & PHShowGraduationAtRight)
	{
		CGContextSetLineWidth(context, width*0.5);
		for (j=0; j < [ticks count]; j++)
		{
			double yf = [[ticks objectAtIndex:j] doubleValue];
			CGFloat y = rect.origin.y+(yf-minimum)/(maximum-minimum)*rect.size.height;
			CGContextMoveToPoint(context, rect.origin.x+rect.size.width,y);
			if (drawOutside) {
				CGContextAddLineToPoint(context, rect.origin.x+rect.size.width+3, y);
			} else {
				CGContextAddLineToPoint(context, rect.origin.x+rect.size.width-3, y);
			}
		}
		CGContextStrokePath(context);
	}
	[ticks release];
	//CGColorRelease(color);
}	


@end
