//
//  GridScene.h
//  AppScaffold
//
//  Created by Sakib Shaikh on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Grid.h"
#import "VarContainer.h"
#import "TouchSheet.h"

@interface GridScene : SPDisplayObjectContainer
{    
    VarContainer *globalVars;
    BOOL inMenu;
    
    Grid *theGrid;
    SPButton* clickButton;
    SPButton* menuButton;
    SPImage* topBar;
    SPImage* bgImg;
    SPTexture* cBtn;
    SPTexture* fBtn;
    SPTextField* txt_mines;
    SPTextField* txt_time;
    SPTextField* txt_status;
    
    TouchSheet* gridSheet;
}

-(id)initGridWithRows:(int)row Cols:(int)col Mines:(int)nMine;

@end
