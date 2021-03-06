//
//  PlayLayer.m
//  tapGame
//
//  Created by 张成龙 on 14-4-22.
//  Copyright 2014年 张成龙. All rights reserved.
//

#import "PlayLayer.h"
@interface PlayLayer()
@property (strong,nonatomic) NSMutableArray* lineControllerArray;
@property int score;
@property bool gameIsOver;
@property float topSpeed;
@end

@implementation PlayLayer
+(CCScene *) sceneWithLevel:(int)level
{
	CCScene *scene = [CCScene node];
	
	PlayLayer *layer = [[PlayLayer alloc]initWithLevel:level];
	
	[scene addChild: layer];
	
	return scene;
}

-(id)initWithLevel:(int)level{
    self=[super initWithColor:ccc4(255, 255, 200, 80)];
    self.lineControllerArray=[[NSMutableArray alloc]init];
    self.touchEnabled=YES;
    self.topSpeed=level*80;
    return self;
}
-(void)onEnterTransitionDidFinish{
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background.caf"];
    float topSpeed=40+self.topSpeed+arc4random()%30;
    LineController* lineController;
    lineController=[[LineController alloc]initWithOwner:self withColumn:0 withMoveSpeed:topSpeed-40];
    [self.lineControllerArray addObject:lineController];
    
    lineController=[[LineController alloc]initWithOwner:self withColumn:1 withMoveSpeed:topSpeed];
    [self.lineControllerArray addObject:lineController];
    
    lineController=[[LineController alloc]initWithOwner:self withColumn:2 withMoveSpeed:topSpeed-80];
    [self.lineControllerArray addObject:lineController];
    
    [self schedule:@selector(update:)];

}
-(void)update:(ccTime)delta{
    for (LineController* lineController in self.lineControllerArray) {
        [lineController onEnterFrame:delta];
    }
}
-(void)checkTouchWithPoint:(CGPoint)point{
    bool gameOver=YES;
    for (LineController* lineController in self.lineControllerArray) {
        if([lineController checkTouchWithPoint:point]){
            gameOver=NO;
            return;
        }
    }

    [self gameOver];
}
-(void)addScore{
    self.score++;
}
-(void)gameOver{
    if (self.gameIsOver) {
        return;
    }
    self.gameIsOver=YES;
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameOverLayer sceneWithWon:NO withScore:self.score] ]];
}
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
        
        UITouch* touch = [touches anyObject];
        CGPoint location = [touch locationInView: touch.view];
        location = [[CCDirector sharedDirector] convertToGL: location];

    //touch right?
        [self checkTouchWithPoint:location];
}
@end
