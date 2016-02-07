//
//  Snippet.h
//  SnippetManager
//
//  Created by Kirill Ushkov on 2/1/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Snippet : NSManagedObject

+ (instancetype)snippetWithAttributes:(NSDictionary*)attributes;

@end

NS_ASSUME_NONNULL_END

#import "Snippet+CoreDataProperties.h"
