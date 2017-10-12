//
//  HomeCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/25.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picview;
@property (weak, nonatomic) IBOutlet UIView *titlebg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *likeLab;
@property (weak, nonatomic) IBOutlet UIView *likebgview;

@end

@implementation HomeCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"HomeCell";
    HomeCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDataWithModel:(Home *)model {
    [self.picview sd_setImageWithURL:[NSURL URLWithString:model.cover_image_url] placeholderImage:PlaceholderImage options:SDWebImageAllowInvalidSSLCertificates];
    self.titleLab.text = model.short_title;
    self.likeLab.text = model.likes_count;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.likebgview.backgroundColor = [MyColor colorWithAlphaComponent:0.5];
    self.titlebg.backgroundColor = [MyColor colorWithAlphaComponent:0.5];
    
//    self.picview.contentMode = UIViewContentModeScaleAspectFill;
//    self.picview.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
