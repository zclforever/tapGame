//
//  LineController.m
//  tapGame
//
//  Created by 张成龙 on 14-4-22.
//  Copyright 2014年 张成龙. All rights reserved.
//

#import "LineController.h"
#import "PlayLayer.h"
@interface LineController()
@property float moveSpeed;
@property int column;
@property int tileInterval;
@end
@implementation LineController
-(id)initWithOwner:(PlayLayer*)owner withColumn:(int)column withMoveSpeed:(float)speed{
    self=[super init];
    self.owner=owner;
    self.boxArray=[[NSMutableArray alloc]init];
    self.moveSpeed=speed;
    self.column=column;

    return self;
}
-(void)gameOver{
    [self.owner gameOver];
}
-(void)removeBox:(Box *)box{
    [box removeAllChildrenWithCleanup:YES];
    [self.owner removeChild:box cleanup:YES];
    [self.boxArray removeObject:box];
}
-(bool)checkTouchWithPoint:(CGPoint)point{
    for (Box* box in self.boxArray) {
        if([box checkTouchWithPoint:point]){
            [[SimpleAudioEngine sharedEngine] playEffect:@"shock.mp3"];
            return YES;
        }
    }
    
    return NO;
}
-(void)addScoreFrom:(Box *)box{
    if (!box.scoreAdded) {
        [self.owner addScore];
    }
}
-(void)onEnterFrame:(ccTime)delta{
    //need add box?

    int tileCount=1+arc4random()%3;
    Box* lastBox=[self.boxArray lastObject];
    if(!lastBox||[lastBox tilesMarginTop]>=self.tileInterval){
        //init and add box
        float innerSpace=20;
        float padding=(320-gLineWidth*3-innerSpace*2)/2;
        float left=padding+self.column*(gLineWidth+innerSpace);
        Box* box=[[Box alloc]initWithOwner:self moveSpeed:self.moveSpeed marginLeft:left tileCount:tileCount];
        [self.boxArray addObject:box];
        [self.owner addChild:box];
        self.tileInterval=1+arc4random()%4;
        
    }
    
    //remove and update box
    int i=0;
    while (i<self.boxArray.count) {
        Box* box=self.boxArray[i];
        if (box.die) {
            [self removeBox:box];
        }else{
            [box onEnterFrame:delta];
            i++;
        }
        
    }
    
    
}
@end
