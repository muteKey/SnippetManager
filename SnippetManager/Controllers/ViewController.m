//
//  ViewController.m
//  SnippetManager
//
//  Created by Kirill Ushkov on 1/31/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "ViewController.h"
#import "DataController.h"
#import "Snippet.h"
#import "NSFileManager+CheckSumCheck.h"

static NSString *CODE_SNIPPETS_PATH = @"/Library/Developer/Xcode/UserData/CodeSnippets/";

@interface ViewController ()
@property (nonatomic, strong) IBOutlet NSArrayController *arrayController;
@property (nonatomic, strong) DataController *dataController;
@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)reloadData {
    __weak typeof (self) wSelf = self;

    [self.apiClient snippetsWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        for (NSDictionary *dict in responseObject) {
            Snippet *snippet = [wSelf.dataController snippetWithAttributes:dict];
            
            NSArray *fileIDs = dict[@"snippetFile"];
            NSString *fileID = [fileIDs firstObject];
            
            [wSelf.apiClient mediaWithID:fileID
                                 success:^(NSURLSessionDataTask *task, id responseObject) {
                                     
                                     NSXMLDocument *doc = (NSXMLDocument *)responseObject;
                                     NSData *data = doc.XMLData;
                                     
                                     NSString *name = [NSString stringWithFormat:@"%@.codesnippet", snippet.snippetIdentifier];
                                     
                                     NSFileManager *fileManager = [NSFileManager defaultManager];
                                     
                                     NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory
                                                                                inDomains:NSUserDomainMask] firstObject];
                                     name = [documentsURL.path stringByAppendingFormat:@"/%@", name];
                                     
                                     
                                     NSError *er = nil;
                                     
                                     [data writeToFile:name
                                               options:NSDataWritingAtomic
                                                 error:&er];
                                     
                                     snippet.snippetFilePath = name;
                                     
                                 }
                                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                                     NSLog(@"Error %@", error);
                                 }];
        }
        
        [wSelf.dataController.managedObjectContext save:nil];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error %@", error);
        
    }];

}

- (IBAction)installTapped:(NSButton *)sender {
    Snippet *snippet = self.arrayController.selectedObjects.firstObject;
    
    NSURL *snippetURL = [NSURL fileURLWithPath:snippet.snippetFilePath];
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:CODE_SNIPPETS_PATH];
    NSURL *urlPath = [NSURL URLWithString:path];
    path = [path stringByAppendingString:snippet.snippetFilePath.lastPathComponent];

    NSError *er = nil;
    
    BOOL contained = [[NSFileManager defaultManager] isFileWithURL:snippetURL containedInDirectoryURL:urlPath error:&er];
    
    if (contained) {
        
        NSString *text = (er) ? er.localizedDescription : @"Snippet already contained in directory";
        
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Error"];
        [alert setInformativeText:text];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        [alert runModal];
    }
    else {
        [[NSFileManager defaultManager] copyItemAtPath:snippet.snippetFilePath
                                                toPath:path
                                                 error:&er];
        NSLog(@"%@ error", er);
    }
}

- (void)setApiClient:(id<ApiClientProtocol>)apiClient {
    _apiClient = apiClient;
    
    [self reloadData];
}

- (DataController *)dataController {
    if (!_dataController) {
        _dataController = [DataController new];
    }
    
    return _dataController;
}

@end
