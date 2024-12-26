The solution involves using `__weak` or `__unsafe_unretained` to prevent the unnecessary retention:

```objectivec
@property (strong, nonatomic) NSMutableArray *myArray;

- (void)someMethod {
    [self.myArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        // Correct: Using __weak to prevent unnecessary retention
        __weak NSString *newString = [obj stringByAppendingString:@"suffix"];
        // ... further operations on newString
    }];
}
```

By declaring `newString` as `__weak`, it doesn't retain the new string object.  This prevents the memory leak.  If you absolutely need to retain `newString` for the lifetime of the block and ensure it's not deallocated before the block finishes, it must be manually released upon completion of the block's work.  Choose the strategy that best fits your scenario.   `__unsafe_unretained` should only be used if you know that `newString` will outlive the block.  It's generally safer to favor `__weak` unless you have a very specific and well understood reason to avoid it.