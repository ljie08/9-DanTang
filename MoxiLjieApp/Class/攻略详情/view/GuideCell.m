//
//  GuideCell.m
//  MoxiLjieApp
//
//  Created by ljie on 2017/9/29.
//  Copyright © 2017年 AppleFish. All rights reserved.
//

#import "GuideCell.h"

@interface GuideCell ()

@property (weak, nonatomic) IBOutlet UILabel *descLab;

@end

@implementation GuideCell

+ (instancetype)myCellWithTableview:(UITableView *)tableview {
    static NSString *cellid = @"GuideCell";
    GuideCell *cell = [tableview dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"GuideCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)setDataWithModel:(Guide *)model {
    self.descLab.text = model.title;
}

+ (CGFloat)cellHeightWithString:(NSString *)string {
    CGFloat height = [LJUtil initWithSize:CGSizeMake(Screen_Width-30, CGFLOAT_MAX) string:string font:15].height;
    
    return height+20;
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
