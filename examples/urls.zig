const std = @import("std");
const Har = @import("har").Har;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    const allocator = arena.allocator();

    var file = try std.fs.cwd().openFile("ziglang.org.har", .{});
    defer file.close();

    const stat = try file.stat();
    const file_size = stat.size;

    const har_str = try file.readToEndAlloc(allocator, file_size);

    const har = try std.json.parseFromSliceLeaky(Har, allocator, har_str, .{
        .allocate = .alloc_always,
    });

    for (har.log.entries) |entry| {
        std.debug.print("{s}\n", .{entry.request.url});
    }
}
