//
//  APM3UParser.h
//  pTV
//
//  Created by Alberto Pasca on 21/04/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APM3UModel : NSObject

@property (nonatomic, readonly) NSString *header;
@property (nonatomic, readonly) NSString *info;
@property (nonatomic, strong  ) NSString *name;
@property (nonatomic, strong  ) NSString *url;

@end

@interface APM3UParser : NSObject

@property (nonatomic, strong  ) NSURL *url;
@property (nonatomic, readonly) NSMutableArray *data;

- (void) parse;

@end
