//
//  Grid.h
//  AppScaffold
//
//  Created by Sakib Shaikh on 3/28/12.
//  Copyright (c) 2012 UCLA. All rights reserved.
//

#import "SPDisplayObjectContainer.h"
#include<stdlib.h>
#import "Que.h"
#import "VarContainer.h"

#define tSide 30

@interface Grid : SPDisplayObjectContainer
{
    @public
    NSMutableArray *tiles;
    
    int nRow;
    int nCol;
    
    int eventRow;
    int eventCol;
    
    int use;
    Que* mineCoords;
    Que* flagCoords;
    VarContainer* globalVars;
    
}

-(id)init;
-(id)initWithRows:(int)row columns:(int)col totMines:(int)totMines variables:(VarContainer *)ptrToVars;

-(void)processAtRow:(int)r Column:(int)c;
-(void)addFlaggedRow:(int)r Column:(int)c;
-(void)removeFlaggedRow:(int)r Column:(int)c;
-(void)revealMines;

-(BOOL)checkFlaggedWon;

@end
