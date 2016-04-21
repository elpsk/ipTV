//
//  APM3UParser.m
//  pTV
//
//  Created by Alberto Pasca on 21/04/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

#import "APM3UParser.h"

@implementation APM3UModel

- (NSString *)header {
    return @"#EXTM3U";
}
- (NSString *)info {
    return @"#EXTINF";
}

@end


@implementation APM3UParser

- (void) parse {

    NSAssert(_url, @"KO - NO URL");

    NSString *fContent   = [NSString stringWithContentsOfURL:_url encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray *fCks = [NSMutableArray arrayWithArray:[fContent componentsSeparatedByString:@"\n"]];

    [fCks removeObjectAtIndex:0];

    NSMutableArray *values = [NSMutableArray array];

    APM3UModel *model = nil;
    for ( int i=0; i<fCks.count; i++ ) {
        if ( i % 2 == 0 ) {
            model = [[APM3UModel alloc] init];
            NSArray *iCks = [fCks[i] componentsSeparatedByString:@","];
            if ( [[iCks objectAtIndex:0] isEqualToString:@""] ) continue;
            model.name = [iCks objectAtIndex:1];
        } else {
            model.url = fCks[i];
            [values addObject:model];
        }
    }

    _data = values;
}

@end


/*
 #EXTM3U
 #EXTINF:0,Rai 1
 http://b2everyrai-lh.akamaihd.net/i/rai1_1@398068/index_1200_av-p.m3u8
*/

