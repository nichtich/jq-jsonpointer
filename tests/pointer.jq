include "jsonpointer";

. as $in | [
  "",
  "/foo",
  "/foo/0",
  "/foo/1",
  "/foo/2",
  "/foo/0/0",
  "/",
  "/a~1b",
  "/c%d",
  "/e^f",
  "/g|h",
  "/i\\j",
  "/k\"l",
  "/ ",
  "/m~0n",
  "/0",
  "/x"
] | map(. as $pointer | ($in | pointer($pointer)))
