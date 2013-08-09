//
//  EmailValidator.h
//  EmailValidator
//
//  Created by Josh Smith on 8/8/13.
//  Copyright (c) 2013 Josh Smith. MIT License

/*! EmailValidator is a class to validate the structure of an email address
 
 It's not completely rfc822 compliant.  It will report localhost and tld-only
 addresses as invalid.  It will also not handle IPv6 addresses.  It's very 
 fast and does not use regular expressions.
 */
@interface EmailValidator : NSObject

/*! 
 @returns BOOL YES if the email is valid, NO if it is not
 @param NSString *emailstr a trimmed string containing a potential 
                           email address.
 */
- (BOOL) validEmail:(NSString *) emailstr;
@end
