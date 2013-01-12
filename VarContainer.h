//
//  VarContainer.h
//  AppScaffold
//
//  Created by Sakib Shaikh on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Variables.h"

@interface VarContainer : SPDisplayObjectContainer
{
    @public
    int clickType;
    int timer;
    int numFlagged;
    int numUnclicked;
    int totNumMines;
    BOOL sheetMoving;
        
    enum gameState curState;
}

@property int clickType, timer, numFlagged, totNumMines, numUnclicked;
@property BOOL sheetMoving;
@property enum gameState curState;

-(void) incrFlagged;
-(void) decrFlagged;
-(void) incrUnclicked;
-(void) decrUnclicked;

@end
