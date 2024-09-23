# HTTP Archive v1.2

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
