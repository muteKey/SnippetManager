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
    
//    [[ApiClient sharedInstance] snippetsWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        for (NSDictionary *dict in responseObject) {
//            NSString *identifier = dict[@"_id"];
//            
//            Snippet *snippet = (Snippet*)[wSelf.dataController findOrCreateObjectWithEntityName:@"Snippet"
//                                                                                      predicate:[NSPredicate predicateWithFormat:@"snippetIdentifier == %@", identifier]
//                                                                              createNewIfAbsent:YES];
//            
//            snippet.snippetIdentifier = identifier;
//            snippet.snippetDescription = dict[@"description"];
//            snippet.snippetShortcut = dict[@"shortcut"];
//            snippet.snippetTitle = dict[@"title"];
//        }
//        
//        [wSelf.dataController.managedObjectContext save:nil];
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//        NSLog(@"error %@", error);
//
//    }];
    
    [[ApiClient sharedInstance] mediaWithSuccess:nil failure:nil];
}

- (DataController *)dataController {
    if (!_dataController) {
        _dataController = [DataController new];
    }
    
    return _dataController;
}

@end
