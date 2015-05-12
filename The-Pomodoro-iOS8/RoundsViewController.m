//
//  RoundsViewController.m
//  The-Pomodoro-iOS8
//
//  Created by Sarah on 5/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "RoundsViewController.h"
#import "RoundsController.h"
#import "Timer.h"



@interface RoundsViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation RoundsViewController





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    RoundsController *roundsController = [RoundsController sharedInstance];
    roundsController.currentRound = indexPath.row;
    [roundsController roundSelected];
    Timer *timerController = [Timer sharedInstance];
    [timerController cancelTimer];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    RoundsController *roundsController = [RoundsController sharedInstance];
    
    NSArray *array = [roundsController roundTimes];
    return [array count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCellID"];
    
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCellID"];
    
    }
    RoundsController *roundsController = [RoundsController sharedInstance];
    
    NSArray *array = [roundsController roundTimes];

    tableViewCell.textLabel.text = [NSString stringWithFormat:@"%d minutes", (int)[array[indexPath.row] integerValue]];
    return tableViewCell;
}


- (instancetype)init  {
    self = [super init];
    
    if (self.view) {
        NSLog(@"self.view exists!");
    } else {
        NSLog(@"self.view doesn't exist!");
    }
    
    if (self) {
        self.tableView = [UITableView new];
        [self.view addSubview:self.tableView];
        
        self.tableView.frame = [[UIScreen mainScreen] bounds];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        NSMutableArray *constraintsMutArr = [NSMutableArray new];
        
        [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSLayoutConstraint *xLeftPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.tableView
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view
                                              attribute:NSLayoutAttributeLeftMargin
                                              multiplier:1.0
                                              constant:0.0];
        [constraintsMutArr addObject:xLeftPosConstraint];
        
        NSLayoutConstraint *yTopPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.tableView
                                              attribute:NSLayoutAttributeTop
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.topLayoutGuide
                                              attribute:NSLayoutAttributeBottom
                                              multiplier:1.0
                                              constant:10.0];
        [constraintsMutArr addObject:yTopPosConstraint];
        
        [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSLayoutConstraint *xRightPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.tableView
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.view
                                              attribute:NSLayoutAttributeRightMargin
                                              multiplier:1.0
                                              constant:0.0];
        [constraintsMutArr addObject:xRightPosConstraint];

        NSLayoutConstraint *yBotPosConstraint = [NSLayoutConstraint
                                              constraintWithItem:self.tableView
                                              attribute:NSLayoutAttributeBottom
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self.bottomLayoutGuide
                                              attribute:NSLayoutAttributeTop
                                              multiplier:1.0
                                              constant:-20.0];
        [constraintsMutArr addObject:yBotPosConstraint];
        
        
        [self.view addConstraints:constraintsMutArr];
        
    }
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(roundComplete)
               name:(NSString *)timerCompletedNotification
             object:nil];
    
    return self;
}


- (void)roundComplete {
    RoundsController *roundsController = [RoundsController sharedInstance];
    NSArray *array = [roundsController roundTimes];
    if (roundsController.currentRound >= [array count])
    
    {
        roundsController.currentRound = 0;
        NSIndexPath *newObject = [NSIndexPath indexPathForRow:roundsController.currentRound inSection:0];
    
        
        [self.tableView selectRowAtIndexPath:newObject animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [roundsController roundSelected];
    
    }else{
        
        roundsController.currentRound++;
        NSIndexPath *newObject = [NSIndexPath indexPathForRow:roundsController.currentRound inSection:0];

        
        [self.tableView selectRowAtIndexPath:newObject animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [roundsController roundSelected];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
