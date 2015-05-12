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
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"Some string"];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Some string"];
    
    }
    RoundsController *roundsController = [RoundsController sharedInstance];
    
    NSArray *array = [roundsController roundTimes];

    tableViewCell.textLabel.text = [NSString stringWithFormat:@"%d", array[indexPath.row]];
    return tableViewCell;
}


- (instancetype)init  {
    self = [super init];
    if (self) {
    self.tableView = [UITableView new];
        [self.view addSubview:self.tableView];

    }
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(roundComplete)
               name:timerCompletedNotification
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
