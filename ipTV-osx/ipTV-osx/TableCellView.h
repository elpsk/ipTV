//
//  TableCellView.h
//  ipTV-osx
//
//  Created by Alberto Pasca on 21/04/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TableCellView : NSTableCellView

@property (nonatomic, strong) IBOutlet NSImageView *leftIcon;
@property (nonatomic, strong) IBOutlet NSTextField *name;

@end
