EmailValidator
==============

This is a non-trivial but still not totally compliant rfc822 email address validator.  


Usage
=============

```
   EmailValidator *e = [EmailValidator alloc] init];
   NSLog(@"Should be correct: %d",[e validEmail:@"\"Josh Smith\" <kognate@gmail.com>"]);
```
