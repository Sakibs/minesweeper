//
//  GridScene.m
//  AppScaffold
//
//  Created by Sakib Shaikh on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GridScene.h"

@implementation GridScene

-(id)initGridWithRows:(int)row Cols:(int)col Mines:(int)nMine
{
    if(self = [super init])
    {
        inMenu = FALSE;
        globalVars = [VarContainer alloc];
        [globalVars setClickType:0];
        [globalVars setTimer:0];
        [globalVars setNumFlagged:0];
        [globalVars setNumUnclicked:row*col];
        [globalVars setTotNumMines:nMine];
        [globalVars setCurState:playing];
        
        
        cBtn = [SPTexture textureWithContentsOfFile:@"cbtn.png"];
        fBtn = [SPTexture textureWithContentsOfFile:@"fbtn.png"];
        [cBtn retain];
        [fBtn retain];
        clickButton = [SPButton buttonWithUpState:cBtn downState:fBtn];
        clickButton.y = 440;
        
        SPTexture* temp1 = [SPTexture textureWithContentsOfFile:@"menuUp.png"];
        SPTexture* temp2 = [SPTexture textureWithContentsOfFile:@"menuDn.png"];
        
        menuButton = [SPButton buttonWithUpState:temp1 downState:temp2];
        menuButton.y=440;
        menuButton.x=160;
        temp1 = [SPTexture textureWithContentsOfFile:@"topbar.png"];
        topBar = [SPImage imageWithTexture:temp1];
                
        bgImg = [SPImage imageWithContentsOfFile:@"back.png"];
        theGrid = [[Grid alloc] initWithRows:row columns:col totMines:nMine variables:globalVars];
        theGrid.y=40;
        
        txt_mines = [SPTextField textFieldWithWidth:130 height:40 text:[NSString stringWithFormat:@"Mines: %i",nMine]];
        txt_mines.fontSize=20;
        txt_mines.fontName=@"Arial";
        txt_mines.hAlign=SPHAlignLeft;
        txt_mines.x=10;
        //txt_mines.border=true;
        
        txt_status = [SPTextField textFieldWithWidth:40 height:40 text:@"IP"];
        txt_status.x = 140;
        txt_status.fontSize=20;
        txt_status.fontName=@"Arial";
        //txt_status.border=true;
        
        txt_time = [SPTextField textFieldWithWidth:130 height:40 text:@"Time: 0"];
        txt_time.fontName=@"Arial";
        txt_time.fontSize=20;
        txt_time.x=180;
        txt_time.hAlign = SPHAlignRight;
        //txt_time.border=true;
        
        gridSheet = [[TouchSheet alloc] initWithGrid:theGrid Variables:globalVars];
        
        [self addChild:bgImg];
        //[self addChild:theGrid];
        [self addChild:gridSheet];
        [self addChild:clickButton];
        [self addChild:menuButton];
        [self addChild:topBar];
        [self addChild:txt_mines];
        [self addChild:txt_status];
        [self addChild:txt_time];
        
        [clickButton addEventListener:@selector(clickButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        [menuButton addEventListener:@selector(menuButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        [self addEventListener:@selector(checkGameState:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
    }
    return self;
}

-(void)updateMineText
{
    [txt_mines setText:[NSString stringWithFormat:@"Mines: %i", [globalVars totNumMines]-[globalVars numFlagged]]];
}

-(void) clickButtonTriggered:(SPEvent *) event
{
    if ([globalVars clickType] == 0) {
        //NSLog(@"Click type was 0");
        clickButton.upState = fBtn;
        clickButton.downState = cBtn;
        [globalVars setClickType:1];
    }
    else {
        //NSLog(@"Click type was 1");
        clickButton.downState = fBtn;
        clickButton.upState = cBtn;
        [globalVars setClickType:0];
    }
}

-(void) menuButtonTriggered:(SPEvent *)event
{
    if(!inMenu) {
        //if the menu hasn't been setup then set it up and display it
        return;
    }
    else {
        //the menu has been setup then release it
        return;
    }
}

-(void) checkGameState:(SPEvent *)event
{
    [self updateMineText];
    
    if ([globalVars curState] == lost) {
        [clickButton removeEventListener:@selector(clickButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        [txt_status setText:@"GO"];
        [self removeEventListener:@selector(checkGameState:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
        [globalVars setClickType:2];
        [theGrid revealMines];
    }
    else if ([globalVars curState] == won)
    {
        [clickButton removeEventListener:@selector(clickButtonTriggered:) atObject:self forType:SP_EVENT_TYPE_TRIGGERED];
        [txt_status setText:@"WN"];
        [self removeEventListener:@selector(checkGameState:) atObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
        [globalVars setClickType:2];
    }
}

-(void)dealloc
{
    [super dealloc];
}

@end
