//
//  GameScene.m
//  freefall
//
//  Created by Peter on 1/1/17.
//  Copyright (c) 2017 peter. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0.2f, -7.8f);
    /* Setup your scene here */
    self.name = @"Fence";
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    
    SKSpriteNode *fireball = [SKSpriteNode spriteNodeWithImageNamed:@"fireball.png"];
    fireball.name = @"fireball";
    fireball.position = CGPointMake(10, 600);
    fireball.zPosition = 1;
    fireball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:fireball.size.width/2];
    fireball.physicsBody.dynamic = YES;
    //fireball.position = CGPointMake(100, self.size.height/2);
    fireball.physicsBody.friction = 0.0;
    fireball.physicsBody.restitution = 0.9;
    fireball.physicsBody.linearDamping = 0.0;
    fireball.physicsBody.angularDamping = 0.0;
    fireball.physicsBody.allowsRotation = NO;
    fireball.physicsBody.mass = 1.0;
    //fireball.physicsBody.velocity = CGVectorMake(150, 300.0);
    fireball.physicsBody.affectedByGravity = YES;
    fireball.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:fireball];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
