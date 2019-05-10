include "jsonpointer";

[ 
  {"foo":[{"/":42}]}
  | pointer_get(["foo","0","/"])
]
