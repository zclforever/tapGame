//
//  PlayLayer.h
//  tapGame
//
//  Created by 张成龙 on 14-4-22.
//  Copyright 2014年 张成龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LineController.h"
#import "GameOverLayer.h"
@interface PlayLayer : CCLayerColor {
    
}
+(CCScene *) sceneWithLevel:(int)level;
-(void)gameOver;
-(void)addScore;
@end
