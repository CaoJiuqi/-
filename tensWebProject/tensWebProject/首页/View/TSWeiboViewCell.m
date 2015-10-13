//
//  TSWeiboViewCell.m
//  tensWebProject
//
//  Created by tens on 15-10-9.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "TSWeiboViewCell.h"
#import "WeiboMedol.h"
#import "UserMedol.h"
#import "weiboImageView.h"
#import "HZPhotoBrowser.h"
#import "ToatterString.h"


#define imageWedth (TSWedth -30)/3 // 每张图片的高度
#define imageSpace 5 // 图片之间的间距

#define OtherSpace 130 //其他视图的高度
#define resetOtherSpace 25

 

@interface TSWeiboViewCell ()
{
    NSArray *_nibArray ;
}
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *UserNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *leavelImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *sourceLable;
@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UITextView *contentTextview;
@property (weak, nonatomic) IBOutlet UIView *toolView;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentsButton;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;
@property (weak, nonatomic) IBOutlet UIView *bgImageView;
@property (strong,nonatomic) weiboImageView *weiboImageView;
@property (weak, nonatomic) IBOutlet UIView *resetWeiboView;
@property (weak, nonatomic) IBOutlet UITextView *resetWeiboText;
@property (weak, nonatomic) IBOutlet UIView *resetWeibobgImage;

@end

@implementation TSWeiboViewCell

- (void)awakeFromNib {
    self.toolView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.toolView.layer.borderWidth = 0.5;

    self.resetWeiboText.textContainerInset = UIEdgeInsetsMake(0, -4, 0, -4);



    
    _nibArray = [[NSBundle mainBundle]loadNibNamed:@"weiboImageView" owner:self options:nil];
    




    



}

-(void)setWeiboMedol:(WeiboMedol *)weiboMedol
{
    _weiboMedol = weiboMedol;
    
    [self setWeiboViews];
    
    // 有转发微博时再设置转发微博数据
    if (_weiboMedol.retweetedWeibo != nil) {
        
        self.resetWeiboView.hidden = NO;
        
        [self setRetWeiboViews];
        
    } else {
        
        self.resetWeiboView.hidden = YES;
    }
    
    
    
    
}

#pragma mark -- 显示微博视图
- (void)setWeiboViews
{

    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_weiboMedol.user.profile_image_url]];
    self.UserNameLable.text = _weiboMedol.user.screen_name;
    self.timeLable.text = _weiboMedol.created_at;
    self.sourceLable.text = _weiboMedol.source;
    
//    self.contentTextview.text = _weiboMedol.text;
    NSLog(@"-->%@",_weiboMedol.text);
    self.contentTextview.attributedText = [ToatterString attributeStringfromString:_weiboMedol.text];
    
    
    if ([_weiboMedol.reposts_count integerValue] > 0) {
        NSString *sharetitle=[NSString stringWithFormat:@"%@",_weiboMedol.reposts_count];
        [self.shareButton setTitle:sharetitle forState:UIControlStateNormal];
    }
    if ([_weiboMedol.comments_count integerValue]> 0) {
        NSString * commentsCount =[NSString stringWithFormat:@"%@",_weiboMedol.comments_count];
        [self.commentsButton setTitle:commentsCount forState:UIControlStateNormal];
        [self.commentsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
    }
    if ([_weiboMedol.attitudes_count integerValue]> 0) {
        
        NSString *goodstr = [NSString stringWithFormat:@"%@",_weiboMedol.attitudes_count];
        [self.goodButton setTitle:goodstr forState:UIControlStateNormal];
    }
    
    // 将之前的视图移除
    [self.weiboImageView removeFromSuperview];
    
    // 添加图片视图
    if (_weiboMedol.pic_urls.count > 0) {

        [self showWeiboImages:_weiboMedol.pic_urls withSuperView:self.bgImageView];
    }
    
}

#pragma mark -- 显示转载微博
-(void)setRetWeiboViews
{
    NSLog(@"开始显示转载微博");
    
    NSString *retWeiboStr = [NSString stringWithFormat:@"@%@ %@",_weiboMedol.retweetedWeibo.user.screen_name, _weiboMedol.retweetedWeibo.text];
    self.resetWeiboText.attributedText = [ToatterString attributeStringfromString:retWeiboStr];
    [self.weiboImageView removeFromSuperview];
    

    
    if (_weiboMedol.retweetedWeibo.pic_urls > 0) {
        
        NSLog(@" 装在微博图片");
        [self showWeiboImages:_weiboMedol.retweetedWeibo.pic_urls withSuperView:self.resetWeibobgImage];
        
    }else
    {
    

    }

}

#pragma mark -- 显示微博图片
- (void)showWeiboImages:(NSArray *)pic_urls withSuperView:(UIView *)supView
{

    
    NSInteger count = pic_urls.count;
    if( count== 1 )
    {
       
        
        self.weiboImageView =  _nibArray[0];
        self.weiboImageView.imageImageURLs = pic_urls;
        self.weiboImageView.height = 150 ;
        self.weiboImageView.width = 150;
        [supView  addSubview:self.weiboImageView];
    }else if(count == 4)
    {
       

        self.weiboImageView =  _nibArray[1];
        self.weiboImageView.imageImageURLs = pic_urls;
        self.weiboImageView.width =imageWedth * 2  + imageSpace ;
        self.weiboImageView.height = self.weiboImageView.width;
        [supView addSubview:self.weiboImageView];
    
    }else
    {

        self.weiboImageView =  _nibArray[2];
        self.weiboImageView.imageImageURLs = pic_urls;
        self.weiboImageView.width = TSWedth - 20 ;
        self.weiboImageView.height = self.weiboImageView.width ;
        [supView addSubview:self.weiboImageView];
    }
}


+(CGFloat)showrangHeight:(WeiboMedol *)medol 
{
    // 计算微博文本的高度
    CGFloat textHeigth = [self setTextHeigth:medol withFont:[UIFont systemFontOfSize:14]];
    
    
    // 计算微博图片的高度
   CGFloat imageHeight =  [self setImageViewHeight:medol];
    CGFloat otherSpace = OtherSpace;
    
    // 计算转发微博的高度
    CGFloat resettextHeight = 0;
    if (medol.retweetedWeibo != nil) {
        resettextHeight = [self setTextHeigth:medol.retweetedWeibo withFont:[UIFont systemFontOfSize:13]];
        imageHeight = [self setImageViewHeight:medol.retweetedWeibo];
        otherSpace += resetOtherSpace;
        
    }
    return   textHeigth +imageHeight +otherSpace + resettextHeight;

}

// 计算 微博图片视图的高度
+ (CGFloat)setImageViewHeight:(WeiboMedol *)medol
{
    CGFloat  count = medol.pic_urls.count;
    if (count == 0) {
        return 0;
    }else if (count == 1) {
        
        return 150;
    }else if(count <= 3)
    {
        return imageWedth ;
        
    }else if( count >3 && count < 7)
    {
        return imageWedth * 2 + imageSpace;
    }
        return imageWedth * 3 + imageSpace * 2 ;
}


+ (CGFloat)setTextHeigth:(WeiboMedol *)medol withFont:(UIFont *)font
{
    CGRect rect =[medol.text boundingRectWithSize:CGSizeMake(TSWedth - 20, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :font}context:nil];
    return ceilf(rect.size.height);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
