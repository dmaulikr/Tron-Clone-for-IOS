//
//  GameScene.h
//  Tron
//
//  Created by Joseph Pecoraro on 3/25/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuLayer.h"
#import "Grid.h"

@interface GameScene : CCLayer {
    Grid *grid;
    
    CCSprite *map;
    CCSprite *player1;
    CCSprite *player2;
    CCSprite *blueNeon;
    
    CGPoint oldPosition;
    CGPoint oldPosition2;
    
    id move1;
    id move2;
    id moveLoop;
    id moveLoop2;
    
    NSString *winner;
    
    int angle;
    int angle2;
    bool isOver;
}

@property (nonatomic, retain) CCSprite *map, *player1, *player2;
@property (nonatomic, retain) id move1, move2, moveLoop, moveLoop2;
@property (nonatomic, retain) Grid *grid;
@property (nonatomic, retain) NSString *winner;

+(id)scene;
-(void) rotateLeft;
-(void) rotateRight;
-(void) setMove;
-(void) setMove2;
-(void) act;
-(void) act2;
-(void) addP1Stream;
-(void) addP2Stream;
-(bool) checkP1Collision;
-(bool) checkP2Collision;
-(void) setWinner:(NSString*) win;
-(void) displayWinnerScreen;
-(void)doNothing:(id)sender;

@end