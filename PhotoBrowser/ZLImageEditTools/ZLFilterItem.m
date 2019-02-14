//
//  ZLFilterItem.m
//  ZLPhotoBrowser
//
//  Created by long on 2018/5/6.
//  Copyright © 2018年 long. All rights reserved.
//

#import "ZLFilterItem.h"
#import "ZLDefine.h"
#import "ZLFilterTool.h"

@interface ZLFilterItem ()
{
    UIImageView *_iconView;
    UILabel *_titleLabel;
}

@end

@implementation ZLFilterItem

- (void)dealloc
{
//    NSLog(@"%s", __func__);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:CGRectZero Image:nil filterType:ZLFilterTypeOriginal target:nil action:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithFrame:CGRectZero Image:nil filterType:ZLFilterTypeOriginal target:nil action:nil];
}

- (id)initWithFrame:(CGRect)frame Image:(UIImage *)image filterType:(ZLFilterType)filterType target:(id)target action:(SEL)action
{
    self = [super initWithFrame:frame];
    if(self){
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:gesture];
        
        CGFloat W = frame.size.width;
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, W-20, W-20)];
        _iconView.image = image;
        _iconView.clipsToBounds = YES;
        _iconView.layer.cornerRadius = 5;
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_iconView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconView.frame) + 5, W, 15)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        self.filterType = filterType;
        self.iconImage = image;
    }
    return self;
}

- (void)setFilterType:(ZLFilterType)filterType
{
    _filterType = filterType;
    NSString *title = nil;
    switch (filterType) {
        case ZLFilterTypeOriginal: title = @"オリジナル"; break;
        case ZLFilterTypeSepia: title = @"ノスタルジック"; break;
        case ZLFilterTypeGrayscale: title = @"黒と白"; break;
        case ZLFilterTypeBrightness: title = @"ハイライト"; break;
        case ZLFilterTypeSketch: title = @"スケッチ"; break;
        case ZLFilterTypeSmoothToon: title = @"カートゥーン"; break;
        case ZLFilterTypeGaussianBlur: title = @"曇りガラス"; break;
        case ZLFilterTypeVignette: title = @"ビネット"; break;
        case ZLFilterTypeEmboss: title = @"エンボス"; break;
        case ZLFilterTypeGamma: title = @"ガンマ"; break;
        case ZLFilterTypeBulgeDistortion: title = @"魚眼レンズ"; break;
        case ZLFilterTypeStretchDistortion: title = @"歪曲ミラー"; break;
        case ZLFilterTypePinchDistortion: title = @"凹レンズ"; break;
        case ZLFilterTypeColorInvert: title = @"反転"; break;
        default: title = nil;
    }
    _titleLabel.text = title;
}

- (void)setIconImage:(UIImage *)iconImage
{
    _iconImage = iconImage;
    [self filterImage:iconImage];
}

- (void)filterImage:(UIImage *)image
{
    if (!image) return;
    //加滤镜
    image = [ZLFilterTool filterImage:image filterType:self.filterType];
    _iconView.image = image;
}

@end
