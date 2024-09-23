# HTTP Archive v1.2

Zig struct definitions for the HTTP Archive v1.2 format.

The HTTP Archive format, or HAR, is a JSON-formatted archive file format for logging of a web browser's interaction with a site. The common extension for these files is .har. - [Wikipedia](<https://en.wikipedia.org/wiki/HAR_(file_format)>)

## Installation

### Save to build.zig.zon

```
zig fetch --save https://github.com/ry-sev/har/archive/refs/heads/master.tar.gz
```

### Add dependency to build.zig

```zig
const har = b.dependency("har", .{
    .target = target,
    .optimize = optimize,
});

exe.root_module.addImport("har", har.module("har"));
```

or just copy the src/har.zig file into your project...
