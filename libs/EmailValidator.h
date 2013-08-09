//
//  EmailValidator.h
//  EmailValidator
//
//  Created by Josh Smith on 8/8/13.
//  Copyright (c) 2013 Josh Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    START,
    IN_QUOTE,
    BETWEEN,
    USERNAME,
    EMAIL_AT,
    DOMAINNAME,
    BAD_STATE,
    TLD,
    VALIDEMAIL
} AllowedState;

@interface EmailValidator : NSObject
- (BOOL) validEmail:(NSString *) emailstr;
@end
