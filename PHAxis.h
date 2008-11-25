//
//  PHAxis.h
//  Graph
//
//  Created by Pierre-Henri Jondot on 30/03/08.
//  Ported to iPhone by brian@fluidmedia.com 08-2008
//

#import <UIKit/UIKit.h>

#define PHEPSILON 1e-5
#ifndef CFGFloat
#define CGFloat float
#endif

//Some flags that can be combined (except for the two last ones)
#define PHShowGrid 1
#define PHShowGraduationAtLeft 2
#define PHShowGraduationAtBottom 2
#define PHShowGraduationAtRight 4
#define PHShowGraduationAtTop 4
#define PHIsLog 8
#define PHSmall 16
#define PHBig 32

@interface PHAxis : NSObject {
	double minimum, maximum;
	double minimumRetained, maximumRetained;
	int style;
	float width;
	UIColor *cocoaColor;
	BOOL drawOutside;
	BOOL predefinedMajorTickWidth;
	double majorTickWidth;
	int minorTicksNumber;
	NSMutableArray *tickValues;
}

@property(nonatomic, retain) NSMutableArray *tickValues;

-(id)initWithStyle:(int)the_style;
-(void)setMinimum: (double)newMinimum maximum:(double)newMaximum;
-(NSMutableArray*)majorTickMarks;
-(NSMutableArray*)minorTickMarks;
-(void)saveValues;
-(double)majorTickWidth;
-(void)calculateMajorTickWidth;
-(double)minimum;
-(double)maximum;
-(int)style;
-(void)setStyle:(int)newStyle;
-(void)setColor:(UIColor*)newColor;
-(UIColor*)color;
-(double)convertValue:(float)x;
-(void)setDrawOutside:(BOOL)value;
-(void)setMajorTickWidth:(double)newValue;
-(void)unsetMajorTickWidth;
-(void)setMinorTicksNumber:(int)newValue;
@end
