//
//  Que.h
//  AppScaffold
//
//  Created by Sakib Shaikh on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Variables.h"
#import "Index.h"

@interface Que : NSObject
{
    Index *top;
    Index *bot;
    Index *itr;
}

-(id) init;

-(void) pushRow:(int)r Col:(int)c;
-(Index *) popIndex;
-(BOOL) inListRow:(int)r Col:(int)c;

-(void) pushPrtyRow:(int)r Col:(int)c;
-(BOOL) removeRow:(int)r Col:(int)c;

-(void) resetItr;
-(void) incrItr;
-(Index *) getItr;


-(void) listAll;

@end
