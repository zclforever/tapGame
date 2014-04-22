//
//  Box.h
//  tapGame
//
//  Created by 张成龙 on 14-4-22.
//  Copyright 2014年 张成龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#ifndef tapGame_const_h
#define tapGame_const_h

#define gTileSize 80.0f
#define gLineWidth 80.0f

#endif
@class LineController;
@interface Box : CCLayerColor {
    
}

-(id)initWithOwner:(LineController*)owner moveSpeed:(float)moveSpeed marginLeft:(float)left tileCount:(int)tileCount;
@property (nonatomic,weak) LineController* owner;
-(void)onEnterFrame:(ccTime)delta;
-(float)tilesMarginTop;
@property bool die;
@property bool scoreAdded;
-(bool)checkTouchWithPoint:(CGPoint)point;
@end
