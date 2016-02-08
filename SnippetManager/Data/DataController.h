//
//  DataController.h
//  SnippetManager
//
//  Created by Kirill Ushkov on 2/1/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Snippet.h"

@interface DataController : NSObject
- (void)initializeCoreData;

@property (strong) NSManagedObjectContext *managedObjectContext;

- (NSManagedObject*)findOrCreateObjectWithEntityName:(NSString*)entityName
                                           predicate:(NSPredicate*)predicate
                                   createNewIfAbsent:(BOOL)createNew;

- (Snippet*)snippetWithAttributes:(NSDictionary*)attributes;


@end
