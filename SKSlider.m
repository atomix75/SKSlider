//
//  SKSlider.m
//


#import "SKSlider.h"

@implementation SKSlider
{
    id currentTarget;
    SEL currentAction;
    BOOL touchInProgress;
    CGRect touchRectanlge;
    CGPoint touchLocation;
}

+ (instancetype)sliderWithActiveImage:(NSString *)image normalImage:(NSString *)normalImage withTarget:(id)target action:(SEL)action
{
    return [[SKSlider alloc] initWithActiveImage:image normalImage:normalImage with:target action:action];
}

- (id)initWithActiveImage:(NSString *)image normalImage:(NSString *)normalImage with:(id)target action:(SEL)action
{
    if (self = [super init]) {
        
        self.userInteractionEnabled = YES;
        
        self.activeSprite = [SKSpriteNode spriteNodeWithImageNamed:image];
        self.normalSprite = [SKSpriteNode spriteNodeWithImageNamed:normalImage];
        
        [self addChild:self.activeSprite];
        [self addChild:self.normalSprite];
        
        self.activeSprite.hidden = YES;
        self.normalSprite.hidden = NO;
        
        currentAction = action;
        currentTarget = target;
        
        touchRectanlge = CGRectMake(-self.activeSprite.frame.size.width/2, -self.activeSprite.frame.size.height/2, self.activeSprite.frame.size.width, self.activeSprite.frame.size.height);
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.activeSprite.hidden = !self.activeSprite.hidden;
    self.normalSprite.hidden = !self.normalSprite.hidden;
    
    touchInProgress = YES;
    //NSLog(@"touched");
    
    if (currentAction) {
        [currentTarget performSelector:currentAction withObject:nil];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touching in touches) {
        if (CGRectContainsPoint(touchRectanlge, [touching locationInNode:self])) {
            UITouch *currentTouch = touching;
            touchLocation = [currentTouch locationInNode:self];
        }
    }
    

    
    if (touchInProgress) {
        //NSLog(@"%f",touchLocation.x);
        self.sliderValue = touchLocation.x;
        if (self.sliderValue > 100) {
            self.sliderValue = 100;
        }
        if (self.sliderValue < -100) {
            self.sliderValue = -100;
        }
    }

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.sliderValue = 0;
    touchInProgress = NO;
    
    self.activeSprite.hidden = !self.activeSprite.hidden;
    self.normalSprite.hidden = !self.normalSprite.hidden;
    

}


@end
