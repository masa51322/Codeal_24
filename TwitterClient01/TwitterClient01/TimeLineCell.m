//
//  TimeLineCell.m
//  TwitterClient01
//
//  Created by Masaru Kurashima on 4/12/14.
//  Copyright (c) 2014 masa.com. All rights reserved.
//

#import "TimeLineCell.h"

@implementation TimeLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.tweeTextLabel = [[UILabel alloc] initWithFrame:CGRectZero]; //詳細はlayout sub view
        self.tweeTextLabel.font = [UIFont systemFontOfSize:14.0f];
        self.tweeTextLabel.textColor = [UIColor blackColor];
        self.tweeTextLabel.numberOfLines = 0;
        //self.tweeTextLabel.highlightedTextColor =[UIColor blueColor];
        [self.contentView addSubview:self.tweeTextLabel];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.nameLabel.font =[UIFont systemFontOfSize:12.0f];
        self.nameLabel.textColor = [UIColor blackColor];
        //self.nameLabel.highlightedTextColor = [UIColor blueColor];
        [self.contentView addSubview:self.nameLabel];
        
        self.profileImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.profileImageView.image = self.image;
        [self.contentView addSubview:self.profileImageView];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.profileImageView.frame = CGRectMake(5, 5, 48, 48);
    self.tweeTextLabel.frame = CGRectMake(58, 5, 257, self.tweetTextLabelHeight); //高さが変わるから、変数になっていることに注目。
    self.nameLabel.frame = CGRectMake(58, self.tweetTextLabelHeight + 15, 257, 12);
}



- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
