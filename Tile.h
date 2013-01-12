//
//  Tile.h
//  AppScaffold
//
//  Created by Sakib Shaikh on 3/26/12.
//  Copyright (c) 2012 UCLA. All rights reserved.
//

#import "Variables.h"
#import <Foundation/Foundation.h>
#import "Grid.h"

@interface Tile : SPDisplayObjectContainer
{
    @public
    SPQuad *tileButton;
    SPImage *tileImg;
    SPButton *tileCover;
    
    enum state tileState;
    int numMines;
    
    int indX;
    int indY;
    
    float coordX;
    float coordY;
    
    Grid *ptrToGrid;
    VarContainer* globalVars;
}

@property int numMines, indX, indY;
@property float coordX, coordY;

//-(id) initWithSide:(int)side;
//-(id) initWithSide:(int)side inX:(int)inX inY:(int)inY;
-(id) initWithSide:(int)side inX:(int)inX inY:(int)inY crdX:(float)crdX crdY:(float)crdY variables:(VarContainer *)ptrToVars;

-(void) setState:(enum state)newState;
-(enum state) getState;

-(void) setTileColor:(uint)color;
-(void) setTileImage;
-(void) setPtrToGrid:(Grid *)theGrid;
-(void) revealMineCover:(int) type;

-(void) clearCover;



@end
