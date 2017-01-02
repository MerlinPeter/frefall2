//
//  GameScene.m
//  freefall
//
//  Created by Peter on 1/1/17.
//  Copyright (c) 2017 peter. All rights reserved.
//

#import "GameScene.h"

static const uint32_t category_fence  = 0x1 << 3;

static const uint32_t category_ball   = 0x1 << 0;
@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0.2f, -7.8f);
    /* Setup your scene here */
    self.name = @"Fence";
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.categoryBitMask=category_fence;
    self.physicsBody.contactTestBitMask=category_ball;
    
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
    fireball.physicsBody.categoryBitMask=category_ball;
    fireball.physicsBody.contactTestBitMask=category_fence;
    [self addChild:fireball];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSString *nameA = contact.bodyA.node.name;
    NSString *nameB = contact.bodyB.node.name;
    SKAction *actionAudioExplode = [SKAction playSoundFileNamed:@"Explosion.wav" waitForCompletion:NO];
    NSString *particleExplosionPath = [[NSBundle mainBundle] pathForResource:@"SpriteExp" ofType:@"sks"];
    SKEmitterNode *particleExplosion = [NSKeyedUnarchiver unarchiveObjectWithFile:particleExplosionPath];
    particleExplosion.position = CGPointMake(0, 0);
    particleExplosion.zPosition = 1;
    //particleExplosion.targetNode = self;
    
   
    
    if (([nameA containsString:@"Fence"] && [nameB containsString:@"fireball"])) {
        NSLog(@"\nWhat collided? %@ %@", nameA, nameB);
        SKAction *actionParticleExplosion = [SKAction runBlock:^{
            [contact.bodyB.node addChild:particleExplosion];
        }];
        SKAction *actionExplodeSequence = [SKAction sequence:@[actionAudioExplode]];
        [contact.bodyB.node runAction:actionExplodeSequence];
        [contact.bodyB.node addChild:particleExplosion];

    }
}
@end
