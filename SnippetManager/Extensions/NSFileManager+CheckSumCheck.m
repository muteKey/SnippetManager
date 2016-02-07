//
//  NSFileManager+CheckSumCheck.m
//  SnippetManager
//
//  Created by Kirill Ushkov on 2/7/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "NSFileManager+CheckSumCheck.h"
#import "NSData+MD5.h"

@implementation NSFileManager (CheckSumCheck)

- (BOOL)isFileWithURL:(NSURL*)fileURL containedInDirectoryURL:(NSURL*)directoryURL error:(NSError**)error {
    if (!fileURL || !directoryURL) {
        return NO;
    }
    
    NSError * er = nil;
    
    NSString *fileMD5 = [[NSData dataWithContentsOfURL:fileURL options:NSDataReadingMappedIfSafe error:&er] MD5];
    
    if (!fileMD5) {
        
        *error = [NSError errorWithDomain:NSCocoaErrorDomain code:NSFileNoSuchFileError userInfo:@{NSLocalizedDescriptionKey : @"No such file"}];
        
        return NO;
    }
    
    NSDirectoryEnumerator *enumerator = [self enumeratorAtURL:directoryURL
                                   includingPropertiesForKeys:@[NSURLNameKey, NSURLIsDirectoryKey]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                 errorHandler:^BOOL(NSURL *url, NSError *error)
    {
        if (error) {
            NSLog(@"[Error] %@ (%@)", error, url);
            return NO;
        }
        
        return YES;
    }];
    
    
    for (NSURL *fileURL in enumerator) {
        NSString *currentFileMD5 = [[NSData dataWithContentsOfURL:fileURL] MD5];
        if ([currentFileMD5 isEqualToString:fileMD5]) {
            return YES;
        }
    }

    return NO;
}

@end
