//
//  FRLogServerDataDefault.h
//  frlog
//
//  Created by Fran on 9/5/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import "JSONModel.h"

@interface FRLogServerDataDefault : JSONModel

@property (nonatomic, strong) NSString *obj_classname;
@property (nonatomic, strong) NSString *obj_content;
@property (nonatomic, strong) NSString *obj_line;
@property (nonatomic, strong) NSString *obj_type;

@end
