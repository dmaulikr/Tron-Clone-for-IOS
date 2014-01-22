//
//  MenuLayer.m
//  Tron
//
//  Created by Joseph Pecoraro on 3/25/13.
//
//

#import "MenuLayer.h"
#import "AppDelegate.h"
#import "GameScene.h"
#import "Grid.h"

#pragma mark - MenuLayer

@implementation MenuLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	MenuLayer *layer = [MenuLayer node];
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        CCMenuItemImage *TronText = [CCMenuItemImage itemWithNormalImage:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/TronTextNeonBlue.png" selectedImage:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/TronTextNeonBlue.png" target:self selector:@selector(doNothing:)];
        
        CCMenuItemImage *Quit = [CCMenuItemImage itemWithNormalImage:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/QuitNeonOrange.png" selectedImage:@"/Users/Joseph/Dropbox/College/COP3530/Tron/Tron/Images/QuitNeonOrange.png" target:self selector:@selector(quit:)];
        
        CCMenuItemImage *PlayGame = [CCMenuItemImage itemWithNormalImage:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/PlayGameNeonOrange.png" selectedImage:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/PlayGameNeonOrange.png" target:self selector:@selector(goToGame:)];
        
        TronText.position = ccp(240, 213);
        Quit.position = ccp(370, 130);
        PlayGame.position = ccp(130, 130);
        
        CCMenu *menu = [CCMenu menuWithItems:TronText, PlayGame, Quit, nil];
		menu.position = ccp(0,0);
        
        [self addChild:menu];
	}
	return self;
}

-(void)doNothing:(id)sender {
    
}

-(void)quit:(id)sender {
    exit(0);
}

-(void)goToGame:(id)sender {
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFlipAngular transitionWithDuration:1 scene: [GameScene node]]];
}

- (void) dealloc
{
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end

