//
//  VarContainer.m
//  AppScaffold
//
//  Created by Sakib Shaikh on 8/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VarContainer.h"

@implementation VarContainer

@synthesize clickType, timer, numFlagged, totNumMines, numUnclicked;
@synthesize sheetMoving;
@synthesize curState;

-(void) incrFlagged
{
    numFlagged++;
}

-(void) decrFlagged
{
    numFlagged--;
}

-(void) incrUnclicked
{
    numUnclicked++;
}

-(void) decrUnclicked
{
    numUnclicked--;
}

@end
