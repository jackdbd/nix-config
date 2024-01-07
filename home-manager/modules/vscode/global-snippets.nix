{
  # https://code.visualstudio.com/docs/editor/userdefinedsnippets#_create-your-own-snippets
  fixme = {
    prefix = ["fixme"];
    description = "Insert a FIXME remark";
    body = ["$LINE_COMMENT FIXME: $0"];
  };
  todo = {
    prefix = ["todo"];
    description = "Insert a TODO remark";
    body = ["$LINE_COMMENT TODO: $0"];
  };
  "define zig struct" = {
    prefix = ["str"];
    description = "Zig: define a struct";
    body = "const Foo = struct {\n    x: f64,\n};";
  };
  "import esm/ts module" = {
    prefix = ["im"];
    description = "Import a ESM/TS module";
    body = "import { $0 } from \"$1\";";
  };
  "import zig std library" = {
    prefix = ["std"];
    description = "Zig: import the standard library";
    body = "const std = @import(\"std\");";
  };
  "log.debug variable and type in zig" = {
    prefix = ["ld" "log" "stdout"];
    description = "Zig: log a variable and its type to stdout";
    body = "std.log.debug(\"$0: {} type: {}\", .{$0, @typeInfo(@TypeOf($0))});";
  };
  "while loop in zig" = {
    prefix = ["loop" "wh"];
    description = "Zig: while loop skeleton";
    body = "var i: usize = 0;\nwhile (i < 10) : (i += 1) {\n    $0\n}";
  };
}
