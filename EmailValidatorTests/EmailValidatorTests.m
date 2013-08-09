//
//  EmailValidatorTests.m
//  EmailValidatorTests
//
//  Created by Josh Smith on 8/8/13.
//  Copyright (c) 2013 Josh Smith. All rights reserved.
//

#import "EmailValidatorTests.h"
#import "EmailValidator.h"

@implementation EmailValidatorTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    EmailValidator *e = [[EmailValidator alloc] init];
    STAssertFalse([e validEmail:@"one"], @"should be bad");
    STAssertTrue([e validEmail:@"kognate@gmail.com"], @"should be good");
    STAssertTrue([e validEmail:@"\"Josh Smith\" <kognate@gmail.com>"], @"should be good");
    STAssertFalse([e validEmail:@"\"Josh Smith\" <kognate@gmailcom>"], @"should be false");
    STAssertTrue([e validEmail:@"\"Josh Smith\" <kognate+one@gmail.com>"], @"should be good");
    STAssertTrue([e validEmail:@"\"kognate+one\"@gmail.com"], @"should be good");
    STAssertTrue([e validEmail:@"kognate+one@gmail.com"], @"should be good");
    STAssertTrue([e validEmail:@"kognate.one@gmail.com"], @"should be good");
    STAssertTrue([e validEmail:@"kognate%one@gmail.com"], @"should be good");
    STAssertTrue([e validEmail:@"\"very@strange.com\"@gmail.com"], @"should be good");
    STAssertTrue([e validEmail:@"\"very@str\\\"ange.com\"@gmail.com"], @"should be good");
    STAssertTrue([e validEmail:@"\"airwatchdemo\emc\"@airwatchdemo.com"], @"should be good");
    
    
    STAssertTrue([e validEmail:@"niceandsimple@example.com"], @"good");
    STAssertTrue([e validEmail:@"very.common@example.com"], @"good");
    STAssertTrue([e validEmail:@"a.little.lengthy.but.fine@dept.example.com"], @"good");
    STAssertTrue([e validEmail:@"disposable.style.email.with+symbol@example.com"], @"good");
    STAssertTrue([e validEmail:@"!#$%&'*+-/=?^_`{}|~@example.org"], @"good");
    STAssertTrue([e validEmail:@"\"()<>[]:,;@\\\"!#$%&'*+-/=?^_`{}| ~.a\"@example.org"], @"good");
    STAssertTrue([e validEmail:@"\"much.more unusual\"@example.com"], @"good");
    STAssertTrue([e validEmail:@"\"very.unusual.@.unusual.com\"@example.com"], @"good");

    // These are all valid, but we don't support them
    STAssertFalse([e validEmail:@"\\\"very.(),:;<>[]\\\".VERY.\\\"very@\\n;\\\"very\\\".unusual\\\"@strange.example.com"], @"good");
    STAssertFalse([e validEmail:@"postbox@com (top-level domains are valid hostnames)"], @"good");
    STAssertFalse([e validEmail:@"admin@mailserver1 (local domain name with no TLD)"], @"good");
    STAssertFalse([e validEmail:@"user@[IPv6:2001:db8:1ff::a0b:dbd0]"], @"good");
    
    
    // less than 70 ms on my machine
    /* for (int i = 0; i < 50000; i++) {
        STAssertTrue([e validEmail:@"\"airwatchdemo\emc\"@airwatchdemo.com"], @"should be good");
    }*/
}

@end
