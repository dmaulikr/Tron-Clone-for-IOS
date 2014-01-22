//
//  Grid.h
//  Tron
//
//  Created by Joseph Pecoraro on 3/27/13.
//
//

#import <Foundation/Foundation.h>

@interface Grid : NSObject {    
    NSString *grid[480][320];
    NSString *gridWithPlayers[480][320];
}

-(void) initGrid;
-(bool) isCollision:(int) x withy:(int) y;
-(void) addStream: (int) sx withStarty:(int) sy withFinalx:(int) fx withFinaly:(int) fy;

@end
