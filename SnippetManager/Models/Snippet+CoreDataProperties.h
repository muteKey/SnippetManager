//
//  Snippet+CoreDataProperties.h
//  SnippetManager
//
//  Created by Kirill Ushkov on 2/1/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Snippet.h"

NS_ASSUME_NONNULL_BEGIN

@interface Snippet (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *snippetDescription;
@property (nullable, nonatomic, retain) NSString *snippetFilePath;
@property (nullable, nonatomic, retain) NSString *snippetShortcut;
@property (nullable, nonatomic, retain) NSString *snippetTitle;
@property (nullable, nonatomic, retain) NSString *snippetIdentifier;

@end

NS_ASSUME_NONNULL_END
