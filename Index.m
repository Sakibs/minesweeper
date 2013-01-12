//
//  Index.m
//  AppScaffold
//
//  Created by Sakib Shaikh on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Index.h"

@implementation Index

-(id)initRow:(int)row Col:(int)col ptr:(Index *)ptr
{
    if(self = [super init])
    {
        r = row;
        c = col;
        next = ptr;
    }
    
    return self;

}

@end
