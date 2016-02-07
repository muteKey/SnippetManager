//
//  NSFileManager+CheckSumCheck.h
//  SnippetManager
//
//  Created by Kirill Ushkov on 2/7/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (CheckSumCheck)

- (BOOL)isFileWithURL:(NSURL*)fileURL containedInDirectoryURL:(NSURL*)directoryURL error:(NSError**)error;

@end
