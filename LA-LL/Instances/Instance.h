//
//  Instance.h
//  LA-LL
//
//  Created by Chance Roberts on 10/10/15.
//  Copyright © 2015 Chance Roberts. All rights reserved.
//

#ifndef Instance_h
#define Instance_h
/**@brief Everything all Instances should have!*/
@interface Instance : NSObject
/**@brief The x position*/
@property float x;
/**@brief The y position*/
@property float y;
/**@brief The velocity in the x direction (Right = Pos.)*/
@property float dX;
/**@brief The velocity in the y direction (Down = Pos.)*/
@property float dY;
/**@brief The width of the object.*/
@property float w;
/**@brief The height of the object.*/
@property float h;
/**@brief The direction it is facing.*/
@property int direc;
/**@brief What collision type? (Solid, Transparent)*/
@property NSString *type;
/**@brief What is the name of the object?*/
@property NSString *index;
/**@brief Initialize an object with position!
 @param X The x position in a 32 by 32 grid.
 @param Y The y position in a 32 by 32 grid.*/
-(id)initWithX:(float)X y:(float)Y;
/**@brief Running code for more depth into collision.
 @param dg: Rotation in the unit circle (in degrees) relative to the current object that the collided object is in.*/
-(void) extraCollisionWithDegree:(int)dg instance: (Instance *)i;
/**@brief Collision check with another instance.
 @param i The instance in question.*/
-(void) collisionWithInstance:(Instance *)i;
/**@brief The command that updates the states of the instances.*/
-(void) updateWithObjects: (NSArray *)i player: (Instance *)p;
/**@brief Sends out an array of things for the SpriteCreator to create a node for the funciton.*/
-(NSArray *) drawWithViewX: (float) vX viewY: (float) vY;
/**@brief Actually moves the objects. TO BE RUN AT THE END OF THE MAIN UPDATE LOOP.*/
-(void) finishUpdate;
@end

#endif /* Instance_h */
