//
//  LineController.h
//  tapGame
//
//  Created by 张成龙 on 14-4-22.
//  Copyright 2014年 张成龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box.h"
#import "SimpleAudioEngine.h"
@class PlayLayer;
@interface LineController : NSObject {
    
}
-(id)initWithOwner:(PlayLayer*)owner withColumn:(int)column withMoveSpeed:(float)speed;
@property (nonatomic,weak) PlayLayer* owner;
@property (nonatomic,strong) NSMutableArray* boxArray;
-(void)onEnterFrame:(ccTime)delta;
-(bool)checkTouchWithPoint:(CGPoint)point;
-(void)removeBox:(Box*)box;
-(void)gameOver;
-(void)addScoreFrom:(Box*)box;
@end
