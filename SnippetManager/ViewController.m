//
//  ViewController.m
//  SnippetManager
//
//  Created by Kirill Ushkov on 1/31/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "ViewController.h"
#import "ApiClient.h"
#import "DataController.h"
#import "Snippet.h"

static NSString *CODE_SNIPPETS_PATH = @"/Library/Developer/Xcode/UserData/CodeSnippets/";

@interface ViewController ()
@property (nonatomic, strong) IBOutlet NSArrayController *arrayController;
@property (nonatomic, strong) DataController *dataController;
@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof (self) wSelf = self;
    
    [[ApiClient sharedInstance] snippetsWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        for (NSDictionary *dict in responseObject) {
            NSString *identifier = dict[@"_id"];
            
            Snippet *snippet = (Snippet*)[wSelf.dataController findOrCreateObjectWithEntityName:@"Snippet"
                                                                                      predicate:[NSPredicate predicateWithFormat:@"snippetIdentifier == %@", identifier]
                                                                              createNewIfAbsent:YES];
            
            snippet.snippetIdentifier = identifier;
            snippet.snippetDescription = dict[@"description"];
            snippet.snippetShortcut = dict[@"shortcut"];
            snippet.snippetTitle = dict[@"title"];
            
            NSArray *fileIDs = dict[@"snippetFile"];
            
            NSString *fileID = [fileIDs firstObject];
            
            [[ApiClient sharedInstance] mediaWithID:fileID
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
                                                
                                                NSLog(@"%@", er.localizedDescription);
                                                
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
    
    NSString *path = [NSHomeDirectory() stringByAppendingString:CODE_SNIPPETS_PATH];
    path = [path stringByAppendingString:snippet.snippetFilePath.lastPathComponent];
    
    NSError *er = nil;
    
    [[NSFileManager defaultManager] copyItemAtPath:snippet.snippetFilePath
                                            toPath:path
                                             error:&er];
    NSLog(@"%@ error", er);
}


- (DataController *)dataController {
    if (!_dataController) {
        _dataController = [DataController new];
    }
    
    return _dataController;
}

@end
