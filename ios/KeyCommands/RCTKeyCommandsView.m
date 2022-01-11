//
//  RCTKeyCommandsView.m
//  Envoy
//
//  Created by Fang-Pen Lin on 3/13/18.
//  Copyright © 2018 Envoy Inc. All rights reserved.
//

#import "RCTKeyCommandsView.h"

@implementation RCTKeyCommandsView {
    NSArray<UIKeyCommand *> *currentKeyCommands;
}

-(instancetype) init {
    self = [super init];
    if (self) {
        currentKeyCommands = @[];
        [self becomeFirstResponder];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (NSArray<UIKeyCommand *> *)keyCommands {
    return currentKeyCommands;
}

- (void) setKeyCommandsWithData:(NSArray<NSDictionary *> *) data {
    currentKeyCommands = @[];
    if (data == (id) [NSNull null]) {
        return;
    }

    NSMutableArray<UIKeyCommand *> *_keyCommands = [NSMutableArray new];

    for (NSDictionary *commandJSON in data) {
        NSString *input = commandJSON[@"input"];
        NSNumber *flags = commandJSON[@"keyModifier"];
        NSString *discoverabilityTitle = commandJSON[@"discoverabilityTitle"];
        if (!flags) {
            flags = @0;
        }
        UIKeyCommand *command;
        if (discoverabilityTitle) {
            command = [UIKeyCommand keyCommandWithInput:input
                                          modifierFlags:[flags integerValue]
                                                 action:@selector(onKeyCommand:)
                                   discoverabilityTitle:discoverabilityTitle];
        } else {
            command = [UIKeyCommand keyCommandWithInput:input
                                          modifierFlags:[flags integerValue]
                                                 action:@selector(onKeyCommand:)];
        }
        [_keyCommands addObject:command];
    }
    currentKeyCommands = [NSArray arrayWithArray:_keyCommands];
}

- (void) onKeyCommand:(UIKeyCommand *)keyCommand {
    if (self.onKeyCommand) {
        self.onKeyCommand(@{
            @"input": keyCommand.input,
            @"keyModifier": [NSNumber numberWithInteger:keyCommand.modifierFlags],
            @"discoverabilityTitle": keyCommand.discoverabilityTitle ? keyCommand.discoverabilityTitle : [NSNull null]
        });
    }
}

@end
