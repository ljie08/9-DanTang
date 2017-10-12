//
//  ProductCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/26.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "ProductCell.h"

@interface ProductCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picview;
@property (weak, nonatomic) IBOutlet UIView *likebgview;
@property (weak, nonatomic) IBOutlet UILabel *likeLab;
@property (weak, nonatomic) IBOutlet UIView *titlebg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@end

@implementation ProductCell

- (void)setDataWithModel:(Danpin *)model {
    [self.picview sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:PlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.titleLab.text = model.name;
    self.priceLab.text = model.price;
    self.likeLab.text = model.favorites_count;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    self.likebgview.backgroundColor = [MyColor colorWithAlphaComponent:0.3];
    self.titlebg.backgroundColor = [MyColor colorWithAlphaComponent:0.3];
    
//    self.picview.contentMode = UIViewContentModeScaleAspectFill;
//    self.picview.clipsToBounds = YES;
}

@end
