//
//  YYKVIPViewController.m
//  YYKuaibo
//
//  Created by Sean Yue on 16/4/19.
//  Copyright © 2016年 iqu8. All rights reserved.
//

#import "YYKVIPViewController.h"
#import "YYKCardSlider.h"
#import "YYKVideos.h"
#import "YYKVideoListModel.h"
#import "YYKPaymentInfo.h"

@interface YYKVIPViewController () <YYKCardSliderDelegate,YYKCardSliderDataSource>
{
    YYKCardSlider *_contentView;
}
@property (nonatomic,retain) YYKVideoListModel *videoModel;
@end

@implementation YYKVIPViewController

DefineLazyPropertyInitialization(YYKVideoListModel, videoModel)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _contentView = [[YYKCardSlider alloc] initWithFrame:self.view.bounds];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _contentView.delegate = self;
    _contentView.dataSource = self;
    [self.view addSubview:_contentView];

    @weakify(self);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"svip_refresh"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        @strongify(self);
        [self loadVideos];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPaidNotification:) name:kPaidNotificationName object:nil];
    
    [self loadVideos];
}

- (void)onPaidNotification:(NSNotification *)notification {
    if ([YYKUtil isSVIP]) {
        [_contentView reloadData];
    }
}

- (void)loadVideos {
    @weakify(self);
    [self.view beginLoading];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.videoModel fetchVideosInSpace:YYKVideoListSpaceVIP page:1 withCompletionHandler:^(BOOL success, id obj) {
        @strongify(self);
        if (!self) {
            return ;
        }
        
        [self.view endLoading];
        self.navigationItem.rightBarButtonItem.enabled = YES;
        
        if (success) {
            [self->_contentView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - YYKCardSliderDelegate,YYKCardSliderDataSource

- (NSUInteger)numberOfCardsInCardSlider:(YYKCardSlider *)slider {
    return self.videoModel.fetchedVideos.programList.count;
}

- (YYKCard *)cardSlider:(YYKCardSlider *)slider cardAtIndex:(NSUInteger)index {
    YYKCard *card = [slider dequeReusableCardAtIndex:index];
    
    if (index < self.videoModel.fetchedVideos.programList.count) {
        YYKVideo *video = self.videoModel.fetchedVideos.programList[index];
        card.imageURL = [NSURL URLWithString:video.coverImg];
        card.title = video.title;
        card.subtitle = video.specialDesc;
        card.lightedDiamond = [YYKUtil isSVIP];
    }
    
    return card;
}

- (void)cardSlider:(YYKCardSlider *)slider didSelectCardAtIndex:(NSUInteger)index {
    if (index < self.videoModel.fetchedVideos.programList.count) {
        YYKVideo *video = self.videoModel.fetchedVideos.programList[index];
        [self switchToPlayProgram:(YYKProgram *)video];
    }
}
@end
