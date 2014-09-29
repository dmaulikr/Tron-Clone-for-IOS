Tron-Clone-for-IOS
==================

Update:
App is currently broken (broke sometime in transition from cocos2d 2.0 to 3.0 and ios 6 to ios 7/8). I plan to rewrite this using swift and spritekit for ios 8.

This is a clone of the traditional Tron style game for IOS. This was written in Objective C, and Cocos2D was used for the graphics. The game is single player only, and is not supported on retina devices, however it does run on IOS 7. I wrote this game while trying to learn both Objective C and the Cocos2d game engine, so the code is a little sloppy, but this is the basic logic: A 2d array is used to store locations of the bike path. This is used for collision detection. The bikes are sprites, and movement is done with cocos2d. The basic AI is that if it sees that it will be blocked a few spaces ahead, it will turn either left or right. 
NOTE: All of the image files are hardcoded, and therefore the game will not run on your computer without additional setup. I have included a few in-game screenshots of the app running on an IOS6 simulator.
