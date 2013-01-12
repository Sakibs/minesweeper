//
//  TouchSheet.m
//  AppScaffold
//
//  Created by Sakib Shaikh on 3/27/12.
//  Copyright (c) 2012 UCLA. All rights reserved.
//

#import "TouchSheet.h"

// --- private interface ---------------------------------------------------------------------------

@interface TouchSheet ()

- (void)onTouchEvent:(SPTouchEvent*)event;

@end

// --- class implementation ------------------------------------------------------------------------

@implementation TouchSheet

- (id)initWithQuad:(SPQuad*)quad Variables:(VarContainer *)ptrToVars
{
    if ((self = [super init]))
    {
        // move quad to center, so that scaling works like expected
        globalVars = ptrToVars;
        mQuad = [quad retain];
        //mQuad.x = -mQuad.width/2;
        //mQuad.y = -mQuad.height/2;        
        [mQuad addEventListener:@selector(onTouchEvent:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        [self addChild:mQuad];
    }
    return self;    
}

-(id)initWithGrid:(Grid *)theGrid Variables:(VarContainer *)ptrToVars
{
    if((self = [super init]))
    {
        globalVars = ptrToVars;
        tileGrid = [theGrid retain];
        [tileGrid addEventListener:@selector(onTouchEvent:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        [self addChild:tileGrid];
    }
    return self;
}


- (id)init
{
    // the designated initializer of the base class should always be overridden -- we do that here.
    SPQuad *quad = [[[SPQuad alloc] init] autorelease];
    tileGrid = NULL;
    return [self initWithQuad:quad Variables:NULL];
}

- (void)onTouchEvent:(SPTouchEvent*)event
{
    NSArray *touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseMoved] allObjects];
    
    if (touches.count == 1)
    {                
        // one finger touching -> move
        SPTouch *touch = [touches objectAtIndex:0];
        [globalVars setSheetMoving:TRUE];

        SPPoint *currentPos = [touch locationInSpace:self.parent];
        SPPoint *previousPos = [touch previousLocationInSpace:self.parent];
        SPPoint *dist = [currentPos subtractPoint:previousPos];
        self.x += dist.x;
        self.y += dist.y;
    }

    /*
    else if (touches.count >= 2)
    {
        // two fingers touching -> rotate and scale
        SPTouch *touch1 = [touches objectAtIndex:0];
        SPTouch *touch2 = [touches objectAtIndex:1];
        
        SPPoint *touch1PrevPos = [touch1 previousLocationInSpace:self.parent];
        SPPoint *touch1Pos = [touch1 locationInSpace:self.parent];
        SPPoint *touch2PrevPos = [touch2 previousLocationInSpace:self.parent];
        SPPoint *touch2Pos = [touch2 locationInSpace:self.parent];
        
        SPPoint *prevVector = [touch1PrevPos subtractPoint:touch2PrevPos];
        SPPoint *vector = [touch1Pos subtractPoint:touch2Pos];
        
        float angleDiff = vector.angle - prevVector.angle;
        self.rotation += angleDiff;   
        
        float sizeDiff = vector.length / prevVector.length;
        self.scaleX = self.scaleY = MAX(0.5f, self.scaleX * sizeDiff);        
    }
    
    touches = [[event touchesWithTarget:self andPhase:SPTouchPhaseEnded] allObjects];
    if (touches.count == 1)
    {
        SPTouch *touch = [touches objectAtIndex:0];
        if (touch.tapCount == 2)
        {
            // bring self to front            
            SPDisplayObjectContainer *parent = self.parent;
            [self retain];
            [parent removeChild:self];
            [parent addChild:self];
            [self release];
        }
    } 
    */
}

- (void)dealloc
{
    // event listeners should always be removed to avoid memory leaks!
    [mQuad removeEventListenersAtObject:self forType:SP_EVENT_TYPE_TOUCH];
    [mQuad release];
    [super dealloc];
}

@end
