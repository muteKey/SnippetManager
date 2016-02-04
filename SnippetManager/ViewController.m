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

@interface ViewController ()
@property (nonatomic, strong) IBOutlet NSArrayController *arrayController;
@property (nonatomic, strong) DataController *dataController;

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
                                                
                                                NSError *er = nil;
                                                
                                                [data writeToFile:name
                                                          options:NSDataWritingAtomic
                                                            error:&er];
                                                
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

- (DataController *)dataController {
    if (!_dataController) {
        _dataController = [DataController new];
    }
    
    return _dataController;
}

@end
