//
//  TouchSheet.h
//  AppScaffold
//
//  Created by Sakib Shaikh on 3/27/12.
//  Copyright (c) 2012 UCLA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "VarContainer.h"
#import "Grid.h"


@interface TouchSheet : SPSprite 
{
@private
    SPQuad *mQuad;
    Grid* tileGrid;
    VarContainer* globalVars;
}

- (id)initWithQuad:(SPQuad*)quad Variables:(VarContainer *)ptrToVars; // designated initializer
- (id)initWithGrid:(Grid*)theGrid Variables:(VarContainer *)ptrToVars;

@end
