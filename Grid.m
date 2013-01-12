//
//  Grid.m
//  AppScaffold
//
//  Created by Sakib Shaikh on 3/28/12.
//  Copyright (c) 2012 UCLA. All rights reserved.
//

#import "Grid.h"
#import "Tile.h"

@implementation Grid

-(id)init
{
    return [self initWithRows:9 columns:9 totMines:10 variables:NULL];
}

-(id)initWithRows:(int)row columns:(int)col totMines:(int)totMines variables:(VarContainer *)ptrToVars
{
    if(self = [super init])
    {
        globalVars = ptrToVars;
        
        nRow = row;
        nCol = col;
        
        mineCoords = [Que alloc];
        flagCoords = [Que alloc];
        
        tiles = [[NSMutableArray arrayWithCapacity:row*col] retain];
        
        int ycoord = 0;
        int xcoord = 0;
        
        int r;
        int c;
        for(r=0; r<row; r++)
        {
            for(c=0; c<col; c++)
            {
                Tile *temp = [[Tile alloc] initWithSide:tSide inX:r inY:c crdX:xcoord crdY:ycoord variables:globalVars];
                [temp setPtrToGrid:self];
                
                [tiles addObject:temp];
                [temp release];
                [self addChild:[tiles objectAtIndex:c+r*col]];
                xcoord+=tSide;
            }
            xcoord = 0;
            ycoord+=tSide;
        }
        
        //select random mine spots
        while (totMines > 0) {
            r = arc4random()%row;
            c = arc4random()%col;
            if ([[tiles objectAtIndex:c+r*col] numMines] == 0) {
                [[tiles objectAtIndex:c+r*col] setNumMines:-1];
                totMines--;
                [mineCoords pushPrtyRow:r Col:c];
            }
        }
        
        //[mineCoords listAll];
        
        //set up numbers and the base tiles and set up event listener
        for (r=0; r<row; r++) {
            for (c=0; c<col; c++) {
                use = 0;
                if ([[tiles objectAtIndex:c+r*col] numMines] != -1) {
                    
                    if (c-1>=0 && [[tiles objectAtIndex:(c-1)+r*col] numMines] == -1) 
                        use++;
                    if (r-1>=0 && [[tiles objectAtIndex:c+(r-1)*col] numMines] == -1) 
                        use++;
                    if (c+1<col && [[tiles objectAtIndex:(c+1)+r*col] numMines] == -1) 
                        use++;
                    if (r+1<row && [[tiles objectAtIndex:c+(r+1)*col] numMines] == -1) 
                        use++;
                    if (c-1>=0 && r-1>=0 && [[tiles objectAtIndex:(c-1)+(r-1)*col] numMines] == -1) 
                        use++;
                    if (c-1>=0 && r+1<row && [[tiles objectAtIndex:(c-1)+(r+1)*col] numMines] == -1) 
                        use++;
                    if (c+1<col && r-1>=0 && [[tiles objectAtIndex:(c+1)+(r-1)*col] numMines] == -1) 
                        use++;
                    if (c+1<col && r+1<row &&[[tiles objectAtIndex:(c+1)+(r+1)*col] numMines] == -1) 
                        use++;
                    
                    [[tiles objectAtIndex:c+r*col] setNumMines:use];
                        
                }
                [[tiles objectAtIndex:c+r*col] setTileImage];
            }
        }
    }
    return self;
}


-(void) processAtRow:(int)r Column:(int)c
{
    Que* temp = [Que alloc];
    [temp pushRow:r Col:c];

    Index* itr;
    itr = [temp popIndex];

    while (itr != NULL) {
        int itrR = itr->r;
        int itrC = itr->c;
        
        [itr dealloc];
        
        if ([[tiles objectAtIndex:itrC+itrR*nCol] numMines] == 0) {
            int rPlus = itrR+1;
            int rMinus = itrR-1;
            int cPlus = itrC+1;
            int cMinus = itrC-1;
            
            if(rMinus>=0 && cMinus>=0 && [[tiles objectAtIndex:cMinus+rMinus*nCol] getState] == unclicked && ![temp inListRow:rMinus Col:cMinus])
            {
                [temp pushRow:rMinus Col:cMinus];
            }
            if(rMinus>=0 && cPlus<nCol && [[tiles objectAtIndex:cPlus+rMinus*nCol] getState] == unclicked && ![temp inListRow:rMinus Col:cPlus])
            {
                [temp pushRow:rMinus Col:cPlus];
            }
            if(rPlus<nRow && cPlus<nCol && [[tiles objectAtIndex:cPlus+rPlus*nCol] getState] == unclicked && ![temp inListRow:rPlus Col:cPlus])
            {
                [temp pushRow:rPlus Col:cPlus];
            }
            if(rPlus<nRow && cMinus>=0 && [[tiles objectAtIndex:cMinus+rPlus*nCol] getState] == unclicked && ![temp inListRow:rPlus Col:cMinus])
            {
                [temp pushRow:rPlus Col:cMinus];
            }
            if(rMinus>=0 && [[tiles objectAtIndex:itrC+rMinus*nCol] getState] == unclicked && ![temp inListRow:rMinus Col:itrC])
            {
                [temp pushRow:rMinus Col:itrC];
            }
            if(rPlus<nRow && [[tiles objectAtIndex:itrC+rPlus*nCol] getState] == unclicked && ![temp inListRow:rPlus Col:itrC])
            {
                [temp pushRow:rPlus Col:itrC];
            }
            if(cMinus>=0 && [[tiles objectAtIndex:cMinus+itrR*nCol] getState] == unclicked && ![temp inListRow:itrR Col:cMinus])
            {
                [temp pushRow:itrR Col:cMinus];
            }
            if(cPlus<nCol && [[tiles objectAtIndex:cPlus+itrR*nCol] getState] == unclicked && ![temp inListRow:itrR Col:cPlus])
            {
                [temp pushRow:itrR Col:cPlus];
            }
        }
       
        [[tiles objectAtIndex:itrC+itrR*nCol] clearCover];
        itr = [temp popIndex];
    }
}

-(void) addFlaggedRow:(int)r Column:(int)c
{
    [flagCoords pushPrtyRow:r Col:c];
}

-(void) removeFlaggedRow:(int)r Column:(int)c
{
    [flagCoords removeRow:r Col:c];
}

-(BOOL) checkFlaggedWon
{
    [mineCoords resetItr];
    [flagCoords resetItr];
    Index* flgCrd = [flagCoords getItr];
    Index* minCrd = [mineCoords getItr];
    
    while (flgCrd!=NULL && minCrd!=NULL) {
        if(flgCrd->r != minCrd->r && flgCrd->c != minCrd->c)
            return false;
        [mineCoords incrItr];
        [flagCoords incrItr];
        flgCrd = [flagCoords getItr];
        minCrd = [mineCoords getItr];
    }
    return true;
}

-(void) revealMines
{
    Index* minCrd;
    minCrd = [mineCoords popIndex];
    
    while (minCrd!=NULL) {
        int r = minCrd->r;
        int c = minCrd->c;
        
        enum state curState = [[tiles objectAtIndex:c+r*nCol] getState];
        if(curState == unclicked)
        {
            [[tiles objectAtIndex:c+r*nCol] revealMineCover:0];
        }
        else if(curState == flagged)
        {
            [[tiles objectAtIndex:c+r*nCol] revealMineCover:1];
        }
        [minCrd dealloc];
        minCrd = [mineCoords popIndex];
    }
    
    //[flagCoords listAll];
    minCrd = [flagCoords popIndex];
    while (minCrd!=NULL) {
        int r = minCrd->r;
        int c = minCrd->c;
        
        //NSLog(@"flagged coord r:%i c:%i", r, c);
        enum state curState = [[tiles objectAtIndex:c+r*nCol] getState];
        
        if(curState == flagged)
            [[tiles objectAtIndex:c+r*nCol] revealMineCover:2];
        
        [minCrd dealloc];
        minCrd = [flagCoords popIndex];
    }
    
}

-(void)dealloc
{
    globalVars = NULL;
    [flagCoords dealloc];
    [mineCoords dealloc];
    [super dealloc];
}

@end
