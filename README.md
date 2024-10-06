### std.json error (or my fault?)

## Introduction
I was trying to learn parsing a REST API json data, and found the site https://dummyjson.com/products that gives back several json responses to practice deserialization.

## My development environment

The zig version can be seen in the screenshot.

![alt text](<Capto_Capture 2024-10-07_01-15-39_AM.png>)

## The error
The program would not compile giving me the error shown below.
My approach was to then start commenting the struct fields leaving only the first, then the first two ... and so on until I found the problem: apparently deserializing the field ```tags: [][]const u8``` the next field ```brand: []const u8,``` is not parsed.


```
error: MissingField
/opt/homebrew/Cellar/zig/0.13.0/lib/zig/std/json/static.zig:785:17: 0x10250b067 in fillDefaultStructValues__anon_9334 (rest-api-test)
                return error.MissingField;
                ^
/opt/homebrew/Cellar/zig/0.13.0/lib/zig/std/json/static.zig:375:13: 0x1024f7bcf in innerParse__anon_9206 (rest-api-test)
            try fillDefaultStructValues(T, &r, &fields_seen);
            ^
/opt/homebrew/Cellar/zig/0.13.0/lib/zig/std/json/static.zig:467:64: 0x1024cfa23 in innerParse__anon_8719 (rest-api-test)
                                arraylist.appendAssumeCapacity(try innerParse(ptrInfo.child, allocator, source, options));
                                                               ^
/opt/homebrew/Cellar/zig/0.13.0/lib/zig/std/json/static.zig:361:49: 0x1024b8bc7 in innerParse__anon_8526 (rest-api-test)
                        @field(r, field.name) = try innerParse(field.type, allocator, source, options);
                                                ^
/opt/homebrew/Cellar/zig/0.13.0/lib/zig/std/json/static.zig:140:19: 0x1024a1e23 in parseFromTokenSourceLeaky__anon_7535 (rest-api-test)
    const value = try innerParse(T, allocator, scanner_or_reader, resolved_options);
                  ^
/opt/homebrew/Cellar/zig/0.13.0/lib/zig/std/json/static.zig:107:20: 0x10247cafb in parseFromTokenSource__anon_4193 (rest-api-test)
    parsed.value = try parseFromTokenSourceLeaky(T, parsed.arena.allocator(), scanner_or_reader, options);
                   ^
/opt/homebrew/Cellar/zig/0.13.0/lib/zig/std/json/static.zig:73:5: 0x1024789cf in parseFromSlice__anon_2976 (rest-api-test)
    return parseFromTokenSource(T, allocator, &scanner, options);
    ^
/Users/flevin58/Develop/Zig/rest-api-test/src/main.zig:69:20: 0x102478807 in main (rest-api-test)
    const parsed = try json.parseFromSlice(Products, allocator, json_data, options);
                   ^
run
└─ run rest-api-test failure
error: the following command exited with error code 1:
/Users/flevin58/Develop/Zig/rest-api-test/zig-out/bin/rest-api-test 
Build Summary: 3/5 steps succeeded; 1 failed (disable with --summary none)
run transitive failure
└─ run rest-api-test failure
error: the following build command failed with exit code 1:
/Users/flevin58/Develop/Zig/rest-api-test/.zig-cache/o/7976fd4ef501393bc4a990167992317e/build /opt/homebrew/Cellar/zig/0.13.0/bin/zig /Users/flevin58/Develop/Zig/rest-api-test /Users/flevin58/Develop/Zig/rest-api-test/.zig-cache /Users/flevin58/.cache/zig --seed 0x4a968c02 -Zd6555d9612ee6937 run
```
