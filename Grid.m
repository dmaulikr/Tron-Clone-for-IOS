//
//  Grid.m
//  Tron
//
//  Created by Joseph Pecoraro on 3/27/13.
//
//

#import "Grid.h"

@implementation Grid

-(id) init {
    self = [super init];
    if(self) {
        [self initGrid];
    }
    return self;
}

-(void) initGrid {
    for(int i =0; i < 480; i ++) {
        for(int k=0; k < 320; k ++) {
            grid[i][k] = @" ";
        }
    }
    for(int i=0; i < 480; i++) {
        grid[i][0] = @"W";
        grid[i][319] = @"W";
    }
    
    for(int i=0; i < 320; i++) {
        grid[0][i] = @"W";
        grid[479][i] = @"W";
    }
}

-(bool) isCollision:(int) x withy:(int)y {
    x--;
    y--;
    y = 320-y;
    if ([grid[x][y]isEqual: @" "]) {
        return false;
    }
    return true;
}

-(void) addStream:(int)sx withStarty:(int)sy withFinalx:(int)fx withFinaly:(int)fy {
    int diffx = fx-sx;
    int diffy = fy-sy;
    fy = 320-fy;
    sy = 320-sy;
    
    if(abs(diffx) > abs(diffy)) {
        if (diffx > 0) {
            for (int i =0; i < (abs(diffx)); i++) {
                for (int k = 0; k < 5; k++) {
                    grid[sx+i-1][sy-3+k] = @"S";
                }
            }
        }
        else {
            for (int i =0; i < (abs(diffx)); i++) {
                for (int k = 0; k < 5; k++) {
                    grid[sx-i][sy-3+k] = @"S";
                }
            }
        }
    }
    else {
        if (diffy > 0) {
            for (int i =0; i < (abs(diffy)); i++) {
                for (int k = 0; k < 5; k++) {
                    grid[sx-3+k][sy-i+1] = @"S";
                }
            }
        }
        else {
            for (int i =0; i < (abs(diffy)); i++) {
                for (int k = 0; k < 5; k++) {
                    grid[sx-3+k][sy-i] = @"S";
                }
            }
        }
    }
    
}

-(void) dealloc {
    [super dealloc];
}

@end
