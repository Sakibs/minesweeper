//
//  Tile.m
//  AppScaffold
//
//  Created by Sakib Shaikh on 3/26/12.
//  Copyright (c) 2012 UCLA. All rights reserved.
//

#import "Tile.h"

@implementation Tile

@synthesize numMines, indX, indY;
@synthesize coordX, coordY;


-(id)initWithSide:(int)side inX:(int)inX inY:(int)inY crdX:(float)crdX crdY:(float)crdY variables:(VarContainer *)ptrToVars
{
    if(self = [super init])
    {
        globalVars = ptrToVars;
        SPTexture *temp = [SPTexture textureWithContentsOfFile:@"blank.png"];
        tileImg = [[SPImage imageWithTexture:temp] retain];
        temp = [SPTexture textureWithContentsOfFile:@"cover.png"];
        tileCover = [[SPButton buttonWithUpState:temp] retain];
        tileCover.x = crdX;
        tileCover.y = crdY;
        
        indX = inX;
        indY = inY;
        coordX = crdX;
        coordY = crdY;
        tileState = unclicked;
        
        tileImg.x = crdX;
        tileImg.y = crdY;
        [self addChild:tileImg];

        [tileCover addEventListener:@selector(coverButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        [self addChild:tileCover];
    }
    return self;

}

-(void)setState:(enum state)newState
{
    //dont do anything if tile state is clicked
    if(tileState == clicked)
        return;
    return;
}

-(enum state)getState
{
    return tileState;
}

-(void)setTileColor:(uint)color
{
    tileButton.color = color;
}

-(void)setTileImage
{
    SPTexture *temp;
    
    if(numMines == 0)
        return;
    else if(numMines == -1)
        temp = [SPTexture textureWithContentsOfFile:@"mine.png"];
    else if(numMines == 1)
        temp = [SPTexture textureWithContentsOfFile:@"one.png"];
    else if(numMines == 2)
        temp = [SPTexture textureWithContentsOfFile:@"two.png"];
    else if(numMines == 3)
        temp = [SPTexture textureWithContentsOfFile:@"three.png"];
    else if(numMines == 4)
        temp = [SPTexture textureWithContentsOfFile:@"four.png"];
    else if(numMines == 5)
        temp = [SPTexture textureWithContentsOfFile:@"five.png"];
    else if(numMines == 6)
        temp = [SPTexture textureWithContentsOfFile:@"six.png"];
    else if(numMines == 7)
        temp = [SPTexture textureWithContentsOfFile:@"seven.png"];
    else if(numMines == 8)
        temp = [SPTexture textureWithContentsOfFile:@"eight.png"];
    [tileImg setTexture:temp];
}

-(void) setPtrToGrid:(Grid *)theGrid
{
    ptrToGrid = theGrid;
}

-(void)coverButtonTriggered:(SPEvent *)event
{
    if([globalVars sheetMoving])
    {
        [globalVars setSheetMoving:FALSE];
        return;
    }
    
    if([globalVars clickType] == 1)
    {
        if(tileState == unclicked)
        {
            if ([globalVars numFlagged] != [globalVars totNumMines]) {
                [globalVars incrFlagged];
                [globalVars decrUnclicked];
                tileState = flagged;
                [ptrToGrid addFlaggedRow:indX Column:indY];
                SPTexture* temp = [SPTexture textureWithContentsOfFile:@"flag.png"];
                tileCover.upState = temp;
                tileCover.downState = temp;
                if ([globalVars numFlagged] == [globalVars totNumMines]) {
                    if([ptrToGrid checkFlaggedWon])
                        [globalVars setCurState:won];
                }
            }
        }
        else if(tileState == flagged)
        {
            [globalVars decrFlagged];
            [globalVars incrUnclicked];
            tileState = unclicked;
            [ptrToGrid removeFlaggedRow:indX Column:indY];
            SPTexture* temp = [SPTexture textureWithContentsOfFile:@"cover.png"];
            tileCover.upState = temp;
            tileCover.downState = temp;
        }
        return;
    }
    else if([globalVars clickType] == 0) 
    {
        if (tileState == flagged) {
            return;
        }
        if (numMines == 0)
            [ptrToGrid processAtRow:indX Column:indY];
        else if (numMines > 0)
            [self clearCover];
        else if (numMines == -1)
        {
            [self clearCover];
            [globalVars setCurState:lost];
        }
    }
     
}

-(void) clearCover
{
    [tileCover removeEventListenersAtObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    tileState = clicked;
    [globalVars decrUnclicked];
    if(([globalVars numFlagged] + [globalVars numUnclicked]) == [globalVars totNumMines])
        [globalVars setCurState:won];
    [self removeChild:tileCover];
}

-(void) revealMineCover:(int)type
{
    //if the tile with the mine was unclicked, replace cover with mineR just to reveal it was there
    if(type == 0)
    {
        SPTexture* temp = [SPTexture textureWithContentsOfFile:@"mineR.png"];
        tileCover.upState = temp;
        tileCover.downState = temp;
        tileState = clicked;
    }
    //if the tile with mine was flagged then replace the cover to indicate it was correctly flagged
    else if(type == 1)
    {
        SPTexture* temp = [SPTexture textureWithContentsOfFile:@"mineY.png"];
        tileCover.upState = temp;
        tileCover.downState = temp;
        tileState = clicked;
    }
    //this case applies to tiles that were flagged and may or may not have been mines
    else if(type == 2)
    {
        NSLog(@"---Found incorrect flag");
        SPTexture* temp = [SPTexture textureWithContentsOfFile:@"mineN.png"];
        tileCover.upState = temp;
        tileCover.downState = temp;
        tileState = clicked;
    }
    return;
}

-(void)dealloc
{
    ptrToGrid = NULL;
    globalVars = NULL;
    [tileCover removeEventListener:@selector(coverButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
    [self removeChild:tileImg];
    [self removeChild:tileCover];
    [tileCover release];
    [tileImg release];
    [super dealloc];
}

@end
