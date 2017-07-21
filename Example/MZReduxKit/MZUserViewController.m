//
//  MZUserViewController.m
//  MZReduxKit
//
//  Created by Monzy on 21/07/2017.
//  Copyright © 2017 monzy613. All rights reserved.
//

#import "MZUserViewController.h"
#import "MZUserState.h"
#import "MZChangeUserInfoAction.h"

@interface MZUserViewController () <MZReduxSubscriber>

@property (weak, nonatomic) IBOutlet UITextView *nameTextView;
@property (weak, nonatomic) IBOutlet UITextView *mottoTextView;

@end

@implementation MZUserViewController

- (void)dealloc {
    [[MZStore sharedStore] unsubscribe:self];
}

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [[MZStore sharedStore] subscribe:self];

    MZUserState *initialState = (MZUserState *)[[MZStore sharedStore] stateWithStateClass:[MZUserState class]];
    if (initialState) {
        [self updateState:initialState];
    }
}

#pragma mark - <MZReduxSubscriber>
- (void)updateState:(MZUserState *)state {
    self.nameTextView.text = state.name;
    self.mottoTextView.text = state.motto;
}

- (Class)stateClass {
    return [MZUserState class];
}

#pragma mark - Action handler
- (IBAction)changeButtonPressed:(id)sender {
    [[MZStore sharedStore] dispatch:[MZChangeUserInfoAction actionWithName:self.nameTextView.text motto:self.mottoTextView.text]];
}

@end
