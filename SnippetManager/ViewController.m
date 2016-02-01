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

@interface ViewController ()
@property (nonatomic, strong) IBOutlet NSArrayController *arrayController;
@property (nonatomic, strong) DataController *dataController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ApiClient sharedInstance] snippetsWithSuccess:^(NSURLSessionDataTask *task, NSArray *snippets) {
        
    }
                                            failure:^(NSURLSessionDataTask *task, NSError *error) {
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
