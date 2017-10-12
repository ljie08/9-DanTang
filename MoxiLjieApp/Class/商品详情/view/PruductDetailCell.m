//
//  PruductDetailCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/27.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "PruductDetailCell.h"

@interface PruductDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;

@end

@implementation PruductDetailCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"PruductDetailCell";
    PruductDetailCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PruductDetailCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDataWithModel:(DanpinXiangxi *)model {
    self.titleLab.text = model.name;
    self.priceLab.text = [NSString stringWithFormat:@"￥ %@", model.price];
    self.descLab.text = model.newdescription;
}

+ (CGFloat)cellHeightWithString:(NSString *)string {
    CGFloat height = [LJUtil initWithSize:CGSizeMake(Screen_Width-30, CGFLOAT_MAX) string:string font:12].height;
    
    return height+65;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
