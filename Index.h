//
//  Index.h
//  AppScaffold
//
//  Created by Sakib Shaikh on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Index : NSObject
{
    @public
    int r;
    int c;
    Index *next;
    
}

-(id)initRow:(int)row Col:(int)col ptr:(Index *)ptr;

@end
