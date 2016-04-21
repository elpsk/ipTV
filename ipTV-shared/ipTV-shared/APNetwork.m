//
//  APNetwork.m
//  pTV
//
//  Created by Alberto Pasca on 21/04/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

#import "APNetwork.h"
#import <AFNetworking/AFNetworking.h>
#include <stdlib.h>

@implementation APNetwork

- (void) getPlaylistWithCompletionHandler:(void (^)(NSURL *filePath, NSError *error))completionHandler {

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    int r = arc4random_uniform(9999);
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://dl.dropboxusercontent.com/u/11796049/piStream/tv-ita.m3u?r=%d", r]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *downloadTask =
    [manager downloadTaskWithRequest:request
                            progress:nil
                         destination:^NSURL *(NSURL *targetPath, NSURLResponse *response)
     {

         NSURL *documentsDirectoryURL = [[NSFileManager defaultManager]
                                         URLForDirectory:NSDocumentDirectory
                                         inDomain:NSUserDomainMask
                                         appropriateForURL:nil
                                         create:NO
                                         error:nil];

         NSURL *destPath = [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
         [[NSFileManager defaultManager] removeItemAtURL:destPath error:nil];

         return destPath;

     } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
         completionHandler(filePath, error);
     }];
    
    [downloadTask resume];
    
}

@end
