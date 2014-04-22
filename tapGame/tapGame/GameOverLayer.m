//
//  GameOverLayer.m
//  tapGame
//
//  Created by 张成龙 on 14-4-23.
//  Copyright 2014年 张成龙. All rights reserved.
//

#import "GameOverLayer.h"


@implementation GameOverLayer
+(CCScene *) sceneWithWon:(bool)won withScore:(int)score
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOverLayer *layer = [[GameOverLayer alloc]initWithWon:won withScore:score];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) initWithWon:(bool)won withScore:(int)score
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",score] fontName:@"Marker Felt" fontSize:64];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2+40 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		
		NSString* string;
        if (won) {
            string=@"win! again?";
        }else{
            string=@"lose! again?";
        }

		[CCMenuItemFont setFontSize:44];
        
		CCMenuItem *gameStart = [CCMenuItemFont itemWithString:string block:^(id sender) {
			
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[PlayLayer scene] ]];
            
		}];
		
        
		
		CCMenu *menu = [CCMenu menuWithItems:gameStart, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 )];
		
		// Add the menu to the layer
		[self addChild:menu];
        
	}
	return self;
}
@end
