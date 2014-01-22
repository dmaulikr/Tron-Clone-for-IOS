//
//  MenuLayer.h
//  Tron
//
//  Created by Joseph Pecoraro on 3/25/13.
//
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"

@interface MenuLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    
}

+(CCScene *) scene;

@end
