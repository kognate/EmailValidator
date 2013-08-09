EmailValidator
==============

This is a non-trivial but still not totally compliant rfc822 email address validator.  


Usage
=============

```
   EmailValidator *e = [EmailValidator alloc] init];
   NSLog(@"Should be correct: %d",[e validEmail:@"\"Josh Smith\" <kognate@gmail.com>"]);
```

See the tests for more.

For G-d's Sake Why?
===================

iOS apparently doesn't ship flex libraries (they're there for Mac OS).  I was working
on a really nice bison grammer for this and then I hit that roadblock.  So I thought,
"Hey, this yak _needs_ shaving."

