//
//  GameOverLayer.h
//  tapGame
//
//  Created by 张成龙 on 14-4-23.
//  Copyright 2014年 张成龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayLayer.h"
@interface GameOverLayer : CCLayer {
    
}
+(CCScene *) sceneWithWon:(bool)won withScore:(int)score;
-(id) initWithWon:(bool)won withScore:(int)score;
@end
