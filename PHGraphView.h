//
//  PHGraphView.h
//  Graph
//
//  Created by Pierre-Henri Jondot on 30/03/08.
//  Ported to iPhone by brian@fluidmedia.com 08-2008
//


#import <uikit/uikit.h>

#import "PHAxis.h"
#import "PHxAxis.h"
#import "PHyAxis.h"
#import "PHGraphObject.h"
#import "PHPoints.h"
#import "PHLineWithCartesianEquation.h"

#define PHOnlyDelegate 0
#define PHCompositeZoomAndDrag 1
#define PHDragAndMove 2
#define PHZoomOnSelection 3

@interface PHGraphView : UIView {
	NSMutableArray *xAxis;
	NSMutableArray *yAxis;
	NSMutableArray *graphObjects;
	BOOL hasBorder;
	float leftBorder;
	float rightBorder;
	float topBorder;
	float bottomBorder;
	CGRect drawableRect;
}

-(void)addPHxAxis:(PHxAxis*)axis;
-(void)addPHyAxis:(PHyAxis*)axis;
-(void)addPHGraphObject:(PHGraphObject*)object;
-(void)removePHxAxis:(PHxAxis*)axis;
-(void)removePHyAxis:(PHyAxis*)axis;
-(void)removePHGraphObject:(PHGraphObject*)object;

//direct accessors to the arrays of axis and objects
-(NSMutableArray*)xAxisMutableArray;
-(NSMutableArray*)yAxisMutableArray;
-(NSMutableArray*)graphObjectsMutableArray;
-(void)setXAxisMutableArray:(NSMutableArray*)anArray;
-(void)setYAxisMutableArray:(NSMutableArray*)anArray;
-(void)setGraphObjectsMutableArray:(NSMutableArray*)anArray;

-(void)setHasBorder:(BOOL)value;
-(void)setLeftBorder:(float)newLeftBorder rightBorder:(float)newRightBorder
		bottomBorder:(float)newBottomBorder topBorder:(float)newTopBorder;
@end