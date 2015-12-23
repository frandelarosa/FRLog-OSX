//
//  FRLogServerObject.h
//  frlog
//
//  Created by Fran de la Rosa on 23/12/15.
//  Copyright © 2015 Fran de la Rosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface FRLogServerObject : JSONModel

@property (nonatomic, strong) NSString<Optional> *obj_line;
@property (nonatomic, strong) NSString<Optional> *obj_type;
@property (nonatomic, strong) NSString<Optional> *obj_classname;

@end
