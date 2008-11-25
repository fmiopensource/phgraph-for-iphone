//
//  PHLineWithCartesianEquation.h
//  PHGraph
//
//  Created by Pierre-Henri Jondot on 12/04/08.
//  Ported to iPhone by brian@fluidmedia.com 08-2008
//

#import <uikit/uikit.h>
#import "PHGraphObject.h"

#define PHStraight 0
#define PHDashed33 1
#define PHDashed8212 2

@interface PHLineWithCartesianEquation : PHGraphObject {
	double a,b,c;
	float width;
	int style;
	UIColor *cocoaColor;
}

-(id)initWithXAxis:(PHxAxis*)xaxis yAxis:(PHyAxis*)yaxis a:(double)aValue b:(double)bValue
		c:(double)cValue;
		
-(void)setWidth:(float)newWidth;
-(void)setStyle:(int)newStyle;
-(void)setEquationA:(double)aValue b:(double)bValue c:(double)cValue;
-(void)setColor:(UIColor*)newColor;

@end
