//
//  EmailValidator.m
//  EmailValidator
//
//  Created by Josh Smith on 8/8/13.
//  Copyright (c) 2013 Josh Smith. MIT License

#import "EmailValidator.h"

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

@interface EmailValidator ()
@property (strong, nonatomic) NSSet *allTLDs;
@end

@implementation EmailValidator {
    NSCharacterSet *letters;
    NSMutableCharacterSet *usernameallowed;
    NSCharacterSet *notletters;
    NSCharacterSet *notalpha;
    NSCharacterSet *white;
    NSCharacterSet *notwhite;
    NSCharacterSet *quote;
    NSCharacterSet *escape;
    NSCharacterSet *lbracket;
    NSCharacterSet *rbracket;
    NSCharacterSet *email_at;
    NSCharacterSet *dot;
}

- (id) init {
    if (self = [super init]) {
        self.allTLDs = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bl", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".eh", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".um", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".yu", @".za", @".zm", @".zw",nil];
        
       letters = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-"];
        
        usernameallowed = [[NSMutableCharacterSet alloc] init];
        [usernameallowed formUnionWithCharacterSet:letters];
        [usernameallowed formUnionWithCharacterSet:[NSCharacterSet symbolCharacterSet]];
        [usernameallowed formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
        [usernameallowed formUnionWithCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        notletters = [letters invertedSet];
        notalpha = [usernameallowed invertedSet];
        white = [NSCharacterSet whitespaceCharacterSet];
        notwhite = [white invertedSet];
        quote = [NSCharacterSet characterSetWithCharactersInString:@"\""];
        escape = [NSCharacterSet characterSetWithCharactersInString:@"\\"];
        lbracket = [NSCharacterSet characterSetWithCharactersInString:@"<"];
        rbracket = [NSCharacterSet characterSetWithCharactersInString:@">"];
        email_at = [NSCharacterSet characterSetWithCharactersInString:@"@"];
        dot = [NSCharacterSet characterSetWithCharactersInString:@"."];
    }
    return self;
}

- (BOOL) isTLD:(NSString *) tld {
    return [self.allTLDs member:tld] != nil;
}

- (BOOL) validEmail:(NSString *) emailstr {
    AllowedState current = START;
    int needsclosingbracket = 0;
    

    char lc = 0;
    
    for (int i=0; i < [emailstr length]; i++) {
        
        char c = [emailstr characterAtIndex:i];
        char nc = 0;

        if ((i + 1) < [emailstr length]) {
            nc = [emailstr characterAtIndex:i+1];
        }
        
        int dotidx = 0;
        
        switch (current) {
            case START:
                if ([quote characterIsMember:c]) {
                    current = IN_QUOTE;
                } else {
                    current = USERNAME;
                }
                break;
            case IN_QUOTE:
                if ([quote characterIsMember:c] && ![escape characterIsMember:lc]) {
                    if ([white characterIsMember:nc]) {
                        current = BETWEEN;
                    } else if ([email_at characterIsMember:nc]) {
                        current = USERNAME;
                    } else {
                        current = BAD_STATE;
                    }
                }
                break;
            case BETWEEN:
                if ([lbracket characterIsMember:c]) {
                    current = USERNAME;
                    needsclosingbracket = 1;
                } else if ([notwhite characterIsMember:c]) {
                    current = BAD_STATE;
                }
                break;
            case USERNAME:
                if ([email_at characterIsMember:c]) {
                    current = EMAIL_AT;
                } else if ([notalpha characterIsMember:c]) {
                    current = BAD_STATE;
                }
                break;
            case EMAIL_AT:
                if ([letters characterIsMember:c]) {
                    current = DOMAINNAME;
                } else {
                    current = BAD_STATE;
                }
                break;
            case DOMAINNAME:
                if ([dot characterIsMember:c]) {
                    dotidx = i;
                } else if ([notletters characterIsMember:c]) {
                    current = BAD_STATE;
                }
                break;
            case TLD:
                if ([rbracket characterIsMember:c]) {
                    current = VALIDEMAIL;
                }
            default:
                break;
        }
        if (dotidx > 0) {
            // TODO: ths tld handling is klunky
            NSRange r = NSMakeRange(dotidx, [emailstr length] - dotidx);
            NSString *tldcheck = [[[emailstr substringWithRange:r] stringByTrimmingCharactersInSet:rbracket] lowercaseString];
            if (current == DOMAINNAME && [self isTLD:tldcheck]) {
                if (needsclosingbracket == 1) {
                    current = TLD;
                } else {
                    current = VALIDEMAIL;
                }
            }
            
        }
        lc = c;
    }
    return current == VALIDEMAIL;
}

@end
