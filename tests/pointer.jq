include "jsonpointer";

. as $in | [
  "",
  "/foo",
  "/foo/0",
  "/foo/1",
  "/",
  "/a~1b",
  "/c%d",
  "/e^f",
  "/g|h",
  "/i\\j",
  "/k\"l",
  "/ ",
  "/m~0n"
] | map(. as $pointer | ($in | pointer($pointer)))
