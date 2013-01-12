//
//  Game.m
//  AppScaffold
//

#import "Game.h" 

@implementation Game

- (id)initWithWidth:(float)width height:(float)height
{
    if ((self = [super initWithWidth:width height:height]))
    {
        // this is where the code of your game will start. 
        // in this sample, we add just a simple quad to see if it works.
        SPQuad* back = [SPQuad quadWithWidth:30 height:37];
        back.x = 10;
        back.y = 55;
        //[self addChild:back];
        
        
        
        //Grid *myGrid = [[Grid alloc] initWithRows:4 columns:4];
        //[self addChild:myGrid];
        //myGrid.x = 10;
        
        //TouchSheet *mytouch = [[TouchSheet alloc] initWithQuad:myGrid];
        //[self addChild:mytouch];

        /*
        Grid *test = [[Grid alloc] init];
        [self addChild:test];
        [test release];
        */ 
        
        /*
        Que *test = [Que alloc];
        
        [test pushPrtyRow:0 Col:1];
        [test pushPrtyRow:1 Col:1];
        [test pushPrtyRow:0 Col:2];
        [test pushPrtyRow:0 Col:0];
        [test pushPrtyRow:5 Col:5];
        [test pushPrtyRow:3 Col:3];
        [test removeRow:0 Col:0];
        [test removeRow:3 Col:3];
        [test removeRow:5 Col:5];
        [test dealloc];
        //*/
        
        ///*
        
        GridScene *testScene = [[GridScene alloc] initGridWithRows:7 Cols:7 Mines:7];
        [self addChild:testScene];
        [testScene release];
        //*/
        
        /*Grid *test = [[Grid alloc] initWithRows:5 columns:5 totMines:10];
         [self addChild:test];
         [test release];
         */

        /*
        Tile *myTile = [[Tile alloc] initWithSide:30 inX:0 inY:0 crdX:10 crdY:10 variables:NULL];
        [self addChild:myTile];
        [self removeChild:myTile];
        [myTile dealloc];
        */
        // Per default, this project compiles as an iPhone application. To change that, enter the 
        // project info screen, and in the "Build"-tab, find the setting "Targeted device family".
        //
        // Now Choose:  
        //   * iPhone      -> iPhone only App
        //   * iPad        -> iPad only App
        //   * iPhone/iPad -> Universal App  
        // 
        // If you want to support the iPad, you have to change the "iOS deployment target" setting
        // to "iOS 3.2" (or "iOS 4.2", if it is available.)
    }
    return self;
}

@end
