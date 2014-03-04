//
//  SKSlider.h
//


#import <SpriteKit/SpriteKit.h>

@interface SKSlider : SKNode

@property (nonatomic, readwrite) CGFloat sliderValue;
@property (nonatomic, strong) SKSpriteNode *activeSprite;
@property (nonatomic, strong) SKSpriteNode *normalSprite;

+ (instancetype)sliderWithActiveImage:(NSString *)image normalImage:(NSString *)normalImage withTarget:(id)target action:(SEL)action;

@end
