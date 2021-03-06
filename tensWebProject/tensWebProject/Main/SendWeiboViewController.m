//
//  SendWeiboViewController.m
//  tensWebProject
//
//  Created by tens on 15-10-14.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "SendWeiboViewController.h"
#import "RequestMedol.h"
#import "ArchiveModel.h"
#import "AFHRequestHttp.h"
#import "MBProgressHUD.h"
#import "ZLPhoto.h"
#import "ZLPhotoAssets.h"
#import "SendImageView.h"
#import "FirendsListViewController.h"
#import "TSNavgationController.h"
#import "EmoationView.h"
#import "EmotionModel.h"
#import "NSString+Emoji.h"
#import "UITextView+ToAttibuteStirng.h"

@interface SendWeiboViewController () <ZLPhotoPickerViewControllerDelegate,delectDelgate,EmotionKeyboardDelegate>
{
    MBProgressHUD *_HUD;
}
@property (weak, nonatomic) IBOutlet UITextView *WeibotextView;
@property (weak, nonatomic) IBOutlet UILabel *placeLable;
@property (weak, nonatomic) IBOutlet UIButton *sendweiboButton;
@property (weak, nonatomic) IBOutlet UIView *toolbuttonView;
@property (weak, nonatomic) IBOutlet UIButton *albumButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *emationButton;
@property (weak, nonatomic) IBOutlet UIButton *topicButton;
@property (weak, nonatomic) IBOutlet UIButton *keybordButton;

@property (nonatomic,strong)SendImageView *photoImageView ;
@property (nonatomic,strong)NSMutableArray *photos;

@property (nonatomic,strong)EmoationView *emationView;

@end

@implementation SendWeiboViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

#pragma mark -- 显示提示
- (void)showHUD:(NSString *)title
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    _HUD.labelText = title;
    _HUD.removeFromSuperViewOnHide = YES;
    [self.view addSubview:_HUD];
    [_HUD show:YES];
}

- (void)hiddenHUD
{
    [_HUD hide:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.WeibotextView becomeFirstResponder];

    /*监听text 输入的内容*/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TextViewchanged) name:UITextViewTextDidChangeNotification object:nil];
    // 监听键盘变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBordChangeFram:) name:UIKeyboardDidChangeFrameNotification object:nil];





    
}


#pragma mark --  监听方法
-(void)TextViewchanged
{
    // 判断是否显示提示文字
    self.placeLable.hidden = self.WeibotextView.hasText;
    // 显示发送按钮是否可以点击
    self.sendweiboButton.enabled = self .WeibotextView.hasText;
}

-(void)keyBordChangeFram:(NSNotification *)notification
{
    // 获取键盘收起或弹起的时间
    NSDictionary *dictionary = notification.userInfo;
    CGFloat duration = [dictionary[@"UIKeyboardAnimationDurationUserInfoKey"]floatValue];
    
    // 获取键盘的高度
    CGFloat keybordY = [dictionary[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue].origin.y;
    CGFloat  keybordHeight = [dictionary[@"UIKeyboardFrameEndUserInfoKey"]CGRectValue].size.height;
    [UIView animateWithDuration:duration animations:^{
        if (keybordY < TSHeight) {
            self.toolbuttonView.transform = CGAffineTransformMakeTranslation(0, -keybordHeight);
        }else
        {
            self.toolbuttonView.transform = CGAffineTransformIdentity;
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)buttonAction:(UIButton *)button
{
    if ( button.tag == 0) {
        [self.view endEditing:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        if (self.photos.count != 0) {
            [self sendImageWeiBo];
        }else{
            [self sendTextWeiBo];
        }
    }
}

#pragma mark -<delectDelgate>
-(void)delectImageWithIndex:(NSInteger)index
{
    [self.photos removeObjectAtIndex:index];

}
#pragma mark--<EmotionKeyboardDelegate>
-(void)clickEmotion:(EmotionModel *)emotion withIndex:(NSInteger)index
{
    if (index == 20) {
        
        [self.WeibotextView deleteBackward];
        
    } else {
        
        self.placeLable.hidden = YES;
        
        if (emotion.code) {
            [self.WeibotextView insertText:emotion.code.emoji];
            
        } else {
            [self.WeibotextView insertEmotion:emotion];
        }
    }
}

// 下面工具按钮的触发事件
- (IBAction)toolButtonAction:(UIButton *)sender {
    
    switch (sender.tag ) {
        case KeyboardToolIsPhoto:{
            [self showImagePickerViewController];
            break;
        }
            
        case KeyboardToolIsCamera:{
            
            break;
        }
        case KeyboardToolIsAt:{
//            [self sortFirends];
            break;
        }
        case KeyboardToolIsTopic:{
            
            break;
        }
        case KeyboardToolIsEmotion:{
            [self creeateEmationView:sender];
            
            break;
        }
        default:
            break;
    }
    
}

#pragma mark--从相册中获取图片
-(void)showImagePickerViewController
{
    ZLPhotoPickerViewController *zlphotoVC = [[ZLPhotoPickerViewController alloc]init];
    
    zlphotoVC.status = PickerViewShowStatusGroup;
    zlphotoVC.maxCount = 9;
    zlphotoVC.delegate = self;
    
    [zlphotoVC showPickerVc:self];

}

#pragma mark--<ZLPhotoPickerViewControllerDelegate>
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets
{

    self.photos = [NSMutableArray array];
    for (ZLPhotoAssets *asset in assets) {
        [self.photos addObject:[asset thumbImage]];
    }
    // 将所有选中的图片 加载到图片视图中
    [self.photoImageView addPhotos:self.photos];
    
}

#pragma mark -- 查找联系人
-(void)sortFirends
{
    FirendsListViewController *friendsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirendsListViewController"];
    TSNavgationController *navagationVC = [[TSNavgationController alloc]initWithRootViewController:friendsVC];
    
    [self presentViewController:navagationVC animated:YES completion:nil];



}

-(void)creeateEmationView:(UIButton *)emationkeybordButton
{
    
    emationkeybordButton.selected = !emationkeybordButton.selected;
    if (!_emationView) {

        _emationView = [[[NSBundle mainBundle]loadNibNamed:@"EmoationView" owner:self options:nil]lastObject];
        _emationView.delegate = self;
    }
    if (!self.WeibotextView.inputView) {
        self.WeibotextView.inputView = _emationView;
    }else{
        self.WeibotextView.inputView = nil;
    }
    [self.WeibotextView  reloadInputViews];
}

#pragma mark--发送文字微博

-(void)sendTextWeiBo
{
    RequestMedol *medol = [ArchiveModel UnArichiveMedol];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:medol.access_token forKey:@"access_token"];
    [dictionary setValue:self.WeibotextView.text forKey:@"status"];
    [self showHUD:@"正在发送"];
    
    [AFHRequestHttp requestURL:TSendWeiboUrl parameters:dictionary requestType:RequestIsPOST success:^(id result) {
        
        [self hiddenHUD];
        [self dismissViewControllerAnimated:YES completion:nil];

        [[NSNotificationCenter defaultCenter] postNotificationName:TSSendWeiboSuccessNotification object:nil];
        [self showHUD:@"发送成功"];

    } failure:^(id error) {
        NSLog(@"errror:%@",error);
    }];
    
    
    
}


#pragma mark -- 发送图片微博
-(void)sendImageWeiBo
{
    RequestMedol *medol = [ArchiveModel UnArichiveMedol];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setValue:medol.access_token forKey:@"access_token"];
    [dictionary setValue:self.WeibotextView.text forKey:@"status"];
    
    [self showHUD:@"正在发送"];
    
    [AFHRequestHttp POSTURL:TSendImageWeiboUrl parameters:dictionary datas:self.photos success:^(id result) {
        [self hiddenHUD];
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:TSSendWeiboSuccessNotification object:nil];
        [self showHUD:@"发送成功"];
        
        
    } failure:^(id error) {
        NSLog(@"errror:%@",error);
        
        
    }];

}


-(SendImageView *)photoImageView
{

    if (_photoImageView == nil) {
        _photoImageView = [[SendImageView alloc]init];
        _photoImageView.delgate = self;
        [self.view addSubview:_photoImageView];
//        [self.view sendSubviewToBack:_photoImageView];

    }
    return _photoImageView;
}

@end
