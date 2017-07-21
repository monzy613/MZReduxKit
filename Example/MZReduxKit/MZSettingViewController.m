//
//  MZSettingViewController.m
//  MZReduxKit
//
//  Created by Monzy on 21/07/2017.
//  Copyright © 2017 monzy613. All rights reserved.
//

#import <MZReduxKit/MZReduxKit.h>

#import "MZSettingViewController.h"
#import "MZSettingState.h"
#import "MZChangeNotificationStateAction.h"

@interface MZSettingViewController () <MZReduxSubscriber>

@property (weak, nonatomic) IBOutlet UISwitch *notificationSwitch;
@property (weak, nonatomic) IBOutlet UILabel *notificationStateLabel;

@end

@implementation MZSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.notificationStateLabel.text = self.notificationSwitch.on ? @"on" : @"off";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[MZStore sharedStore] subscribe:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [[MZStore sharedStore] unsubscribe:self];
}

#pragma mark - <MZReduxSubscriber>
- (void)updateState:(MZSettingState *)state {
    self.notificationStateLabel.text = state.isNotificationOn ? @"on" : @"off";
}

- (Class)stateClass {
    return [MZSettingState class];
}

#pragma mark - Action handler
- (IBAction)switchChanged:(UISwitch *)sender {
    MZChangeNotificationStateAction *action = [MZChangeNotificationStateAction new];
    action.isOn = sender.on;

    [[MZStore sharedStore] dispatch:action];
}

@end
