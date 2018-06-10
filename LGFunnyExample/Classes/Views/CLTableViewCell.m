//
//  CLTableViewCell.m
//  LGFunnyExample
//
//  Created by 李刚 on 2018/6/10.
//  Copyright © 2018年 LiGang. All rights reserved.
//

#import "CLTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface CLTableViewCell()

@property (nonatomic) UILabel *titleLabel;

@property (nonatomic) UILabel *descriptionLabel;

@property (nonatomic) UIImageView *avatarImageView;

@property (nonatomic) CLCellModel *model;

@end

static CGFloat const avatarWidth = 50;

@implementation CLTableViewCell

#pragma mark -Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

#pragma mark -Public

- (void)bindWithModel:(CLCellModel *)model {
    self.model = model;
    self.titleLabel.text = model.titleStr;
    self.descriptionLabel.text = model.descriptionStr;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.imageHref] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    
    [self updateConstraintsIfNeeded];
}

#pragma mark -Pravite

- (void)initSubviews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview:self.avatarImageView];
}

#pragma mark -Overwrite

- (void)updateConstraints {
    [super updateConstraints];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10).priorityHigh();
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right);
    }];

    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.titleLabel.mas_left);
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).offset(-10).priorityHigh();
        make.right.equalTo(self.avatarImageView.mas_left).offset(-10);
    }];

    // adjust height
    UIImage *image = self.avatarImageView.image;
    CGSize size = image.size;
    CGFloat height = size.height / size.width * avatarWidth;
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionLabel);
        make.right.equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(avatarWidth);
        make.height.mas_equalTo(height).with.priorityHigh();
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).offset(-10);
    }];
}

#pragma mark -Geters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blueColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _descriptionLabel;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
    }
    return _avatarImageView;
}

@end
