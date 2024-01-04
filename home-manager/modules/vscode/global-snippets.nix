{
  fixme = {
    body = ["$LINE_COMMENT FIXME: $0"];
    description = "Insert a FIXME remark";
    prefix = ["fixme"];
  };
  todo = {
    body = ["$LINE_COMMENT TODO: $0"];
    description = "Insert a TODO remark";
    prefix = ["todo"];
  };
  "define zig struct" = {
    "prefix" = "str";
    "body" = "const Foo = struct {\n    x: f64,\n};";
    "description" = "Define a struct";
  };
  "import esm/ts module" = {
    prefix = "im";
    body = "import { $0 } from \"$1\";";
  };
  "import zig std library" = {
    prefix = "std";
    body = "const std = @import(\"std\");";
    description = "Import Zig standard library";
  };
  "log.debug variable and type in zig" = {
    "prefix" = "ld";
    "body" = "std.log.debug(\"$0: {} type: {}\", .{$0, @typeInfo(@TypeOf($0))});";
    "description" = "Log a variable and its type to stdout";
  };
  "while loop in zig" = {
    "prefix" = "wh";
    "body" = "var i: usize = 0;\nwhile (i < 10) : (i += 1) {\n    $0\n}";
    "description" = "while loop skeleton";
  };
}
