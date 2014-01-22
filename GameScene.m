//
//  GameScene.m
//  Tron
//
//  Created by Joseph Pecoraro on 3/25/13.
//
//

#import "GameScene.h"

@implementation GameScene
@synthesize map, winner, player1, player2, move1, move2, moveLoop, moveLoop2, grid;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	GameScene *layer = [GameScene node];
	
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        [self setIsTouchEnabled:TRUE];
        isOver = false;
        angle = 0;
        angle2 = 0;
        
        grid = [[Grid alloc] init];
        
        map = [CCSprite spriteWithFile:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/TronBackground.png"];
        map.position = ccp(240,160);
        
        player1 = [CCSprite spriteWithFile:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/TronBikeBlueMedium.png"];
        player2 = [CCSprite spriteWithFile:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/TronBikeOrangeMedium.png"];
        player1.position = ccp(360,100);
        player2.position = ccp(120,220);
        oldPosition = player1.position;
        
        [player2 runAction:[CCRotateTo actionWithDuration:.001 angle:180]];
        angle2=180;
        oldPosition2 = player2.position;
        
        [self addChild:player1 z:5];
        [self addChild:player2 z:5];
        [self addChild:map z:-1];
        
        move1 = [CCMoveBy actionWithDuration:.01 position:ccp(0,1)];
        move2 = [CCMoveBy actionWithDuration:.01 position:ccp(0,-1)];
        
        moveLoop2 = [CCRepeat actionWithAction:move2 times:1000];
        [self act];
        [player2 runAction:moveLoop2];
        [self scheduleUpdate];
	}
	return self;
}

- (void) update:(ccTime) time {
    if (!isOver) {
        [self addP1Stream];
        [self addP2Stream];
        if ([self checkP1Collision]) {
            NSLog(@"%s", "True");
            [self stopAllActions];
            isOver = true;
            [self setWinner: @"Computer"];
        }
        else if([self checkP2Collision]) {
            NSLog(@"%s", "True2");
            [self stopAllActions];
            isOver = true;
            [self setWinner: @"Player1"];
        }
        else {
            [self act2];
        }
    }
    else if (isOver) {
        [self displayWinnerScreen];
    }
}

- (void) addP1Stream {
    CGPoint diff = ccpSub(player1.position, oldPosition);
    if (abs(diff.y) > abs(diff.x)) {
        if (diff.y > 0) {
            for (int i = 0; i < diff.y; i ++) {
                CCSprite *s = [CCSprite spriteWithFile:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/NeonBlueStreamSq.png"];
                s.position = ccp(player1.position.x, player1.position.y-i);
                [self addChild:s z:1];
            }
        }
        else if (diff.y < 0) {
            for (int i = 0; i < abs(diff.y); i ++) {
                CCSprite *s = [CCSprite spriteWithFile:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/NeonBlueStreamSq.png"];
                s.position = ccp(player1.position.x, player1.position.y+i);
                [self addChild:s z:1];
            }
        }
    }
    else if (abs(diff.x) > abs(diff.y)) {
        if (diff.x > 0) {
            for (int i = 0; i < diff.x; i ++) {
                CCSprite *s = [CCSprite spriteWithFile:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/NeonBlueStreamSq.png"];
                s.position = ccp(player1.position.x-i, player1.position.y);
                [self addChild:s z:1];
            }
        }
        else if (diff.x < 0) {
            for (int i = 0; i < abs(diff.x); i ++) {
                CCSprite *s = [CCSprite spriteWithFile:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/NeonBlueStreamSq.png"];
                s.position = ccp(player1.position.x+i, player1.position.y);
                [self addChild:s z:1];
            }
        }
    }
    [grid addStream:oldPosition.x withStarty:oldPosition.y withFinalx:player1.position.x withFinaly:player1.position.y];
    oldPosition = player1.position;
}

- (void) addP2Stream {
    CGPoint diff = ccpSub(player2.position, oldPosition2);
    if (abs(diff.y) > abs(diff.x)) {
        if (diff.y > 0) {
            for (int i = 0; i < diff.y; i ++) {
                CCSprite *s = [CCSprite spriteWithFile:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/NeonOrangeStreamSq.png"];
                s.position = ccp(player2.position.x, player2.position.y-i);
                [self addChild:s z:1];
            }
        }
        else if (diff.y < 0) {
            for (int i = 0; i < abs(diff.y); i ++) {
                CCSprite *s = [CCSprite spriteWithFile:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/NeonOrangeStreamSq.png"];
                s.position = ccp(player2.position.x, player2.position.y+i);
                [self addChild:s z:1];
            }
        }
    }
    else if (abs(diff.x) > abs(diff.y)) {
        if (diff.x > 0) {
            for (int i = 0; i < diff.x; i ++) {
                CCSprite *s = [CCSprite spriteWithFile:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/NeonOrangeStreamSq.png"];
                s.position = ccp(player2.position.x-i, player2.position.y);
                [self addChild:s z:1];
            }
        }
        else if (diff.x < 0) {
            for (int i = 0; i < abs(diff.x); i ++) {
                CCSprite *s = [CCSprite spriteWithFile:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/NeonOrangeStreamSq.png"];
                s.position = ccp(player2.position.x+i, player2.position.y);
                [self addChild:s z:1];
            }
        }
    }
    [grid addStream:oldPosition2.x withStarty:oldPosition2.y withFinalx:player2.position.x withFinaly:player2.position.y];
    oldPosition2 = player2.position;
}

-(bool) checkP1Collision {
    int x = player1.position.x;
    int y = player1.position.y;
    
    if (sin(angle*M_PI/180) == 1) {
        x+=17;
    }
    else if (cos(angle*M_PI/180) == 1) {
        y+=17;
    }
    else if (cos(angle*M_PI/180) == -1) {
        y-=17;
    }
    else if (sin(angle*M_PI/180) == -1) {
        x-=17;
    }
    return [grid isCollision: x withy: y];
    
}

-(bool) checkP2Collision {
    int x=player2.position.x;
    int y=player2.position.y;
    
    if (sin(angle2*M_PI/180) == 1) {
        x+=17;
    }
    else if (cos(angle2*M_PI/180) == 1) {
        y+=17;
    }
    else if (cos(angle2*M_PI/180) == -1) {
        y-=17;
    }
    else if (sin(angle2*M_PI/180) == -1) {
        x-=17;
    }
    
    return [grid isCollision: x withy: y];

}

-(void) act {
    [self stopAction:moveLoop];
    moveLoop = [CCRepeat actionWithAction:move1 times:1000];
    [player1 runAction:moveLoop];
}

-(void) act2 {
    int x=player2.position.x;
    int y=player2.position.y;
    
    if (sin(angle2*M_PI/180) == 1) {
        x+=30;
        NSLog(@"%s", "East");
    }
    else if (cos(angle2*M_PI/180) == 1) {
        y+=30;
        NSLog(@"%s", "North");
    }
    else if (cos(angle2*M_PI/180) == -1) {
        y-=30;
        NSLog(@"%s", "South");
    }
    else if (sin(angle2*M_PI/180) == -1) {
        x-=30;
        NSLog(@"%s", "West");
    }
    
    int add = -3;
    for (int i = 0; i < 5; i ++) {
        x = x+add;
        y = y+add;
        if ([grid isCollision: x withy: y]) {
            [self stopAction:moveLoop2];
            float randomNum = (rand() / RAND_MAX);
            if (randomNum < .5) {
                [self rotateLeft2];
                NSLog(@"%s", "Rotate Left");
            }
            else {
                [self rotateRight2];
                NSLog(@"%s", "Rotate Right");
            }
            moveLoop2 = [CCRepeat actionWithAction:move2 times:1000];
            [player2 runAction:moveLoop2];
            break;
        }
        add+=i;
    }
}

-(void) setWinner:(NSString *)win {
    winner = win;
}

-(void) displayWinnerScreen {
    NSString *winText = nil;
    if ([winner isEqual:(@"Player1")]) {
        winText = @"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/WinBlue.png";
    }
    else {
        winText = @"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/LossRed.png";
    }
    
    CCMenuItemImage *Result = [CCMenuItemImage itemWithNormalImage:winText selectedImage:winText target:self selector:@selector(doNothing:)];
    
    CCMenuItemImage *Quit = [CCMenuItemImage itemWithNormalImage:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/QuitNeonOrange.png" selectedImage:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/QuitNeonOrange.png" target:self selector:@selector(quit:)];
    
    CCMenuItemImage *PlayGame = [CCMenuItemImage itemWithNormalImage:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/PlayAgain.png" selectedImage:@"/Users/Joseph/Dropbox/College/Spring 2013/COP3530/Tron/Tron/Images/PlayAgain.png" target:self selector:@selector(newGame:)];
    
    Result.position = ccp(240, 200);
    Quit.position = ccp(380, 130);
    PlayGame.position = ccp(140, 130);
    
    CCMenu *menu = [CCMenu menuWithItems:Result, PlayGame, Quit, nil];
    menu.position = ccp(0,0);
    
    [self addChild:menu z:8];
}

-(void)quit:(id)sender {
    exit(0);
}

-(void)newGame:(id)sender {
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFlipAngular transitionWithDuration:1 scene: [GameScene node]]];
}

-(void) rotateRight {
    [player1 runAction:[CCRotateBy actionWithDuration:.001 angle:90]];
    angle+=90;
    [self setMove];
    [self act];
}

-(void) rotateLeft {
    [player1 runAction:[CCRotateBy actionWithDuration:.001 angle:-90]];
    angle-=90;
    [self setMove];
    [self act];
}

-(void) rotateRight2 {
    [player2 runAction:[CCRotateBy actionWithDuration:.001 angle:90]];
    angle2+=90;
    [self setMove2];
    moveLoop2 = [CCRepeat actionWithAction:move2 times:1000];
    [player2 runAction:moveLoop2];
}

-(void) rotateLeft2 {
    [player2 runAction:[CCRotateBy actionWithDuration:.001 angle:-90]];
    angle2-=90;
    [self setMove2];
    moveLoop2 = [CCRepeat actionWithAction:move2 times:1000];
    [player2 runAction:moveLoop2];
}

-(void) setMove {
    if (sin(angle*M_PI/180) == 1) {
        move1 = [CCMoveBy actionWithDuration:.01 position:ccp(1,0)];
    }
    else if (cos(angle*M_PI/180) == 1) {
        move1 = [CCMoveBy actionWithDuration:.01 position:ccp(0,1)];
    }
    else if (cos(angle*M_PI/180) == -1) {
        move1 = [CCMoveBy actionWithDuration:.01 position:ccp(0,-1)];
    }
    else if (sin(angle*M_PI/180) == -1) {
        move1 = [CCMoveBy actionWithDuration:.01 position:ccp(-1,0)];
    }
}

-(void) setMove2 {
    if (sin(angle2*M_PI/180) == 1) {
        move2 = [CCMoveBy actionWithDuration:.01 position:ccp(1,0)];
    }
    else if (cos(angle2*M_PI/180) == 1) {
        move2 = [CCMoveBy actionWithDuration:.01 position:ccp(0,1)];
    }
    else if (cos(angle2*M_PI/180) == -1) {
        move2 = [CCMoveBy actionWithDuration:.01 position:ccp(0,-1)];
    }
    else if (sin(angle2*M_PI/180) == -1) {
        move2 = [CCMoveBy actionWithDuration:.01 position:ccp(-1,0)];
    }
}

-(void) stopAllActions {
    [player1 stopAllActions];
    [player2 stopAllActions];
}

-(void) registerWithTouchDispatcher {
    [[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (!isOver) {
        CGPoint touchLocation = [touch locationInView: [touch view]];
        touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];

        if (touchLocation.x < 100) {
            [self rotateLeft];
        }
        else if (touchLocation.x > 380) {
            [self rotateRight];
        }
    }
}

-(void) dealloc {
    map = nil;
    
    [super dealloc];
}

@end
