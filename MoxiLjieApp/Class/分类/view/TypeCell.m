//
//  TypeCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/26.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "TypeCell.h"

@interface TypeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picview;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation TypeCell

- (void)setDataWithModel:(TypeBtn *)model {
    [self.picview sd_setImageWithURL:[NSURL URLWithString:model.icon_url] placeholderImage:PlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.titleLab.text = model.name;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
