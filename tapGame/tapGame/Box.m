//
//  Box.m
//  tapGame
//
//  Created by 张成龙 on 14-4-22.
//  Copyright 2014年 张成龙. All rights reserved.
//

#import "Box.h"
#import "LineController.h"
@interface Box()
@property float moveSpeed;
@property float tileCount;
@property (nonatomic)  int touchRightCount;
@property (nonatomic,strong) CCLayerColor* maskLayer;

@end

@implementation Box

-(id)initWithOwner:(LineController *)owner moveSpeed:(float)moveSpeed marginLeft:(float)left tileCount:(int)tileCount{
    self=[super initWithColor:ccc4(242, 242, 242, 185) width:gTileSize height:gTileSize*tileCount];
    self.anchorPoint=ccp(0,0);
    self.position=ccp(left,480);
    self.tileCount=tileCount;
    self.moveSpeed=moveSpeed;
    self.owner=owner;

    self.maskLayer=[[CCLayerColor alloc]initWithColor:ccc4(32, 32, 32, 225) width:gTileSize height:0];
    self.maskLayer.anchorPoint=ccp(0,0);
    self.maskLayer.position=ccp(0,0);
    [self addChild:self.maskLayer]; //need remove
    return self;
}

-(void)onEnterFrame:(ccTime)delta{
    if (self.die) {
        return;
    }
    //update position
    float moveDistanceY=self.moveSpeed*delta;
    self.position=ccp(self.position.x,self.position.y-moveDistanceY);

    if (self.position.y<5&&self.touchRightCount<self.tileCount){
            
            [self.owner gameOver];
        return;

    }
    if(self.position.y<4){
        [self.owner addScoreFrom:self];
        self.scoreAdded=YES;
    }

    if(self.position.y<-gTileSize*3){
                self.die=YES;

    }
}
-(void)setTouchRightCount:(int)touchRightCount{
    _touchRightCount=touchRightCount;
    [self drawWithTouchRightCount];
}
-(void)drawWithTouchRightCount{
    if(self.touchRightCount<=self.tileCount){
        self.maskLayer.contentSize=CGSizeMake(gTileSize, self.touchRightCount*gTileSize);
        
    }
}
-(bool)checkTouchWithPoint:(CGPoint)point{
    
    if(CGRectContainsPoint([self boundingBox], point)){
        self.touchRightCount++;
        if (self.touchRightCount>self.tileCount) {
            return NO;
        }
        return YES;
    }
    return NO;
    
}
-(float)tilesMarginTop{
    float tiles=(480-(self.position.y+gTileSize*self.tileCount))/gTileSize;
    return tiles;
}
@end

