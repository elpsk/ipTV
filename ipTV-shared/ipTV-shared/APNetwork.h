//
//  APNetwork.h
//  pTV
//
//  Created by Alberto Pasca on 21/04/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APNetwork : NSObject

- (void) getPlaylistWithCompletionHandler:(void (^)(NSURL *filePath, NSError *error))completionHandler;

@end
