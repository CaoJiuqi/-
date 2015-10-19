//
//  EmoationView.m
//  tensWebProject
//
//  Created by tens on 15-10-17.
//  Copyright (c) 2015年 tens. All rights reserved.
//

#import "EmoationView.h"
#import "EmationCell.h"
#import "EmoationManager.h"

static NSString *const emationID = @"emationCell";

@interface EmoationView () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *emationConnectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic,strong)NSArray * defaultEmotions;
@property (strong, nonatomic) NSArray *emojiEmotions;
@property (strong, nonatomic) NSArray *lxhEmotions;

@property (strong,nonatomic)NSMutableArray *emation2D;
@end

@implementation EmoationView

-(void)awakeFromNib
{
    // 使用KVC设置pageControl图片
    [self.pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
    [self.pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];

    [self.emationConnectionView registerClass:[EmationCell class] forCellWithReuseIdentifier:emationID];
    [self loadEmationData];
    
}


- (IBAction)emationselectbuttonAction:(UIButton *)sender {
    
    
}

-(void)loadEmationData
{
    self.defaultEmotions = [EmoationManager loadEmotionData:DefaultEmotionFileName];

    self.emojiEmotions = [EmoationManager loadEmotionData:EmojiEmotionFileName];
    
    self.lxhEmotions = [EmoationManager loadEmotionData:LxhEmotionFileName];

    [self setEmaftionData:self.defaultEmotions];
    [self setEmaftionData:self.emojiEmotions];
    [self setEmaftionData:self.lxhEmotions];
    
}


/* 将传入的数据放在对应的而为数组中*/
-(void)setEmaftionData:(NSArray *)data
{
    NSMutableArray *array = nil;
    for(int i =0; i < data.count; i++) {
        
        if (i % 20 == 0 ) {
            array = [[NSMutableArray alloc]init];
            [self.emation2D addObject:array];
        }
        
        [array addObject:data[i]];
    }

}


#pragma mark--<UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 21;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return self.emation2D.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:emationID forIndexPath:indexPath];

    cell.item = indexPath.item;
    
    NSArray *sectionEmotions = self.emation2D[indexPath.section];
    if (indexPath.item < sectionEmotions.count) {
        cell.emotion = sectionEmotions[indexPath.item];
    }
    return  cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat cellWH= (TSWedth - 50)/7;
    return CGSizeMake(cellWH, cellWH);

}

/*点击时触发大方法*/
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionEmotions = self.emation2D[indexPath.section];
    
    EmotionModel *emotion = indexPath.item < sectionEmotions.count ? sectionEmotions[indexPath.item] : nil;
    
    if ([self.delegate respondsToSelector:@selector(clickEmotion:withIndex:)]) {
        
        [self.delegate clickEmotion:emotion withIndex:indexPath.item];
    }
}

-(NSMutableArray *)emation2D
{
    if (_emation2D == nil) {
        _emation2D = [[NSMutableArray alloc]init];
    }
    return _emation2D;
}


@end
