//
//  FRLogServerDataURL.h
//  frlog
//
//  Created by Fran on 9/5/15.
//  Copyright (c) 2015 Fran de la Rosa. All rights reserved.
//

#import "FRLogServerObject.h"

@interface FRLogServerDataURL : FRLogServerObject

@property (nonatomic, strong) NSString<Optional> *obj_requestname;
@property (nonatomic, strong) NSString<Optional> *obj_url;

@end
