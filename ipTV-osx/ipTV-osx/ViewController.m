//
//  ViewController.m
//  ipTV-osx
//
//  Created by Alberto Pasca on 21/04/16.
//  Copyright © 2016 albertopasca.it. All rights reserved.
//

#import "ViewController.h"
#import "TableCellView.h"
#import "APNetwork.h"
#import "APM3UParser.h"


@interface ViewController() <NSTableViewDataSource, NSTableViewDelegate>
{
    IBOutlet NSTableView *_tableView;
    NSArray *_tableData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView.delegate   = self;
    _tableView.dataSource = self;

    APNetwork *net = [[APNetwork alloc] init];
    [net getPlaylistWithCompletionHandler:^(NSURL *filePath, NSError *error) {
        _tableData = [self getChannels:filePath];
        [_tableView reloadData];
    }];

}

- (NSArray*) getChannels:(NSURL*)fUrl {
    APM3UParser *parser = [[APM3UParser alloc] init];
    [parser setUrl:fUrl];
    [parser parse];
    return parser.data;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}


// +---------------------------------------------------------------------------+
#pragma mark - Tableview
// +---------------------------------------------------------------------------+


- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    return 40;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    TableCellView *tvc = (TableCellView*)[tableView makeViewWithIdentifier:@"fileCellId" owner:nil];

    APM3UModel *model = (APM3UModel*)[_tableData objectAtIndex:row];
    tvc.name.stringValue = model.name;
//    cell.detailTextLabel.text = model.url;

    return tvc;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {

    int row = (int)_tableView.selectedRow;
    if ( row != -1 ) {
        APM3UModel *model = (APM3UModel*)[_tableData objectAtIndex:row];
        [self openChannel:model.url];
    }

}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _tableData.count;
}


- (void) openChannel:(NSString*)url
{
    NSDictionary* errorDict;
    NSAppleEventDescriptor* returnDescriptor = NULL;

    NSAppleScript* scriptObject = [[NSAppleScript alloc] initWithSource:
                                   [NSString stringWithFormat:
                                    @"\
                                    tell application \"QuickTime Player\"\n\
                                    open URL \"%@\"\n\
                                    end tell",
                                    url]];

    returnDescriptor = [scriptObject executeAndReturnError: &errorDict];

    NSArray* apps = [NSRunningApplication runningApplicationsWithBundleIdentifier:@"com.apple.QuickTimePlayerX"];
    [(NSRunningApplication*)[apps objectAtIndex:0] activateWithOptions: NSApplicationActivateAllWindows];
}


@end




