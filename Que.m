//
//  Que.m
//  AppScaffold
//
//  Created by Sakib Shaikh on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Que.h"

@implementation Que

-(id) init
{
    if (self = [super init]) {
        top = NULL;
        bot = NULL;
        itr = NULL;
    }
    return self;
}


-(void) pushRow:(int)r Col:(int)c
{
    if (top == NULL) {
        top = [[Index alloc] initRow:r Col:c ptr:NULL];
        //[top retain];
        bot = top;
    }
    else {
        bot->next = [[Index alloc] initRow:r Col:c ptr:NULL];
        bot = bot->next;
        //[bot retain];
    }
}

-(Index *)popIndex
{
    Index *temp;
    if (top == NULL){
        temp = top;
        return temp;
    }
    if (top == bot) {
        temp = top;
        top = NULL;
        bot = NULL;
    }
    else {
        temp = top;
        top = top->next;
    }
    temp->next = NULL;
    return temp;
}

-(void) pushPrtyRow:(int)r Col:(int)c
{
    [self resetItr];
    Index* temp = [self getItr];
    
    //take care of the empty case
    if (temp == NULL) {
        top = [[Index alloc] initRow:r Col:c ptr:NULL];
        bot = top;
        return;
    }
    
    //at this point temp still points to the top so check if the new coordinates will be the new top of the list
    if (r < temp->r || (r == temp->r && c < temp->c)) {
        Index* newIn = [[Index alloc] initRow:r Col:c ptr:top];
        top = newIn;
        return;
    }
    /*
    else if(r == temp->r && c < temp->c)
    {
        Index* newIn = [[Index alloc] initRow:r Col:c ptr:top];
        top = newIn;
        return;
    }
    */
    
    
    Index* tempNext = temp->next;
    
    while (temp != NULL) {
        //if were looking at the last object in the queue
        if (tempNext == NULL) {
            Index* newIn = [[Index alloc] initRow:r Col:c ptr:tempNext];
            temp->next = newIn;
            bot = newIn;
            return;
        }
        //deal with case where we want to put it in the middle somewhere
        else if(temp->r == r && tempNext -> r == r)
        {
            if (temp->c < c && tempNext->c > c) {
                Index* newIn = [[Index alloc] initRow:r Col:c ptr:tempNext];
                temp->next = newIn;
                return;
            }
        }
        else if(temp->r <= r && tempNext->r > r)
        {
            Index* newIn = [[Index alloc] initRow:r Col:c ptr:tempNext];
            temp->next = newIn;
            return;
        }
        
        [self incrItr];
        temp = [self getItr];
        tempNext = temp->next;
    }
}

-(BOOL) removeRow:(int)r Col:(int)c
{
    Index* temp;
    [self resetItr];
    temp = [self getItr];
    
    //take care of the case of the first object
    if(top != NULL && temp->r == r && temp->c==c)
    {
        top = temp->next;
        //if one and only object
        if(temp == bot)
        {
            bot = NULL;
        }
        [temp dealloc];
        return true;
    }
    
    while (temp != NULL) {        
        /*//special case of last object
        if (temp->next == NULL) {
            if (temp->r == r && temp->c == c) {
                bot = NULL;
                [temp dealloc];
                return true;
            }
            else return false;
        }
        */
        if(temp->next->r == r && temp->next->c == c)
        {
            if(temp->next == bot)
            {
                bot = temp;
            }
            Index* rm = temp->next;
            temp->next = rm->next;
            [rm dealloc];
            return true;
        }
        [self incrItr];
        temp = [self getItr];
        
    }
    //at this point we did not find the coordinate, return false and there is an error!!
    return false;
}

-(void) resetItr
{
    itr = top;
}

-(void) incrItr
{
    itr = itr->next;
}

-(Index *) getItr
{
    return itr;
}


-(void) listAll
{
    Index *iter;
    
    iter = top;
    
    NSLog(@"STARTING\n");
    while (iter != NULL) {
        int isBot = 0;
        if (iter == bot) {
            isBot = 1;
        }
        NSLog(@"r:%i, c:%i, isBot:%i \n", iter->r, iter->c, isBot);
        
        iter = iter->next;
    }
    NSLog(@"REACHED END\n");
}

-(BOOL) inListRow:(int)r Col:(int)c
{
    Index *iter = top;
    while (iter != NULL) {
        if (iter->r == r && iter->c == c) {
            return true;
        }
        iter = iter->next;
    }
    return false;
}

-(void) dealloc
{
    Index* temp;
    temp = [self popIndex];
    while (temp!=NULL) {
        [temp dealloc];
        temp = [self popIndex];
    }
    itr = NULL;
    top = NULL;
    bot = NULL;
    
    [super dealloc];
}

@end
