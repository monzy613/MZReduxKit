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

- (void)dealloc {
    [[MZStore sharedStore] unsubscribe:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MZStore sharedStore] subscribe:self];

    MZSettingState *initialState = (MZSettingState *)[[MZStore sharedStore] stateWithStateClass:[MZSettingState class]];
    if (initialState) {
        [self updateState:initialState];
    } else {
        self.notificationStateLabel.text = self.notificationSwitch.on ? @"on" : @"off";
    }
}

#pragma mark - <MZReduxSubscriber>
- (void)updateState:(MZSettingState *)state {
    self.notificationStateLabel.text = state.isNotificationOn ? @"on" : @"off";
    self.notificationSwitch.on = state.isNotificationOn;
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
