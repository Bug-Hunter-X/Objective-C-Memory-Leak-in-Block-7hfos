In Objective-C, a common yet subtle issue arises when dealing with memory management, specifically with regards to retaining objects within blocks.  Consider the following scenario:

```objectivec
@property (strong, nonatomic) NSMutableArray *myArray;

- (void)someMethod {
    [self.myArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // Incorrect: Creating a strong reference within the block
        NSString *newString = [obj stringByAppendingString:@"suffix"];
        // ... further operations on newString
    }];
}
```

The problem lies in how `newString` is created.  Because `newString` is a strong reference created *inside* the block, it is retained. When the block completes, there may be no other strong references to `newString`, leading to a memory leak.  Even if `obj` is released, `newString` persists.