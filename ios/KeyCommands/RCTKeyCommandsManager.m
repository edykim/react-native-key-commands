//
//  RCTKeyCommandManager.m
//  Envoy
//
//  Created by Fang-Pen Lin on 3/13/18.
//  Copyright © 2018 Envoy Inc. All rights reserved.
//

#import "RCTKeyCommandsManager.h"
#import "RCTKeyCommandsView.h"

@implementation RCTKeyCommandsManager

RCT_EXPORT_MODULE();

RCT_EXPORT_VIEW_PROPERTY(onKeyCommand, RCTBubblingEventBlock)
RCT_CUSTOM_VIEW_PROPERTY(keyCommands, NSArray<UIKeyCommand *>, RCTKeyCommandsView) {
    NSArray<NSDictionary *> *data = [RCTConvert NSDictionaryArray: json];
    [view setKeyCommandsWithData: data];
}

- (UIView *)view {
    return [[RCTKeyCommandsView alloc] init];
}

@end
