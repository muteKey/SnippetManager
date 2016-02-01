//
//  Snippet+CoreDataProperties.m
//  SnippetManager
//
//  Created by Kirill Ushkov on 2/1/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Snippet+CoreDataProperties.h"

@implementation Snippet (CoreDataProperties)

@dynamic snippetTitle;
@dynamic snippetDescription;
@dynamic snippetShortcut;
@dynamic snippetFilePath;

@end
