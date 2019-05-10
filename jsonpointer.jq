module {
  "name": "jsonpointer",
  "description": "jq module implementing JSON Pointer (RFC 6901)",
  "homepage": "https://github.com/nichtich/jq-jsonpointer#readme",
  "license": "MIT",
  "author": "Jakob Voß",
  "repository": {
    "type": "git",
    "url": "https://github.com/nichtich/jq-jsonpointer.git"
  }
};

def pointer_tokens:
  . as $pointer |
  if $pointer == "" then
    []
  else
    $pointer | split("/") | 
    if .[0] == "" then
      .[1:] | map(gsub("~1";"/";"g")|gsub("~0";"~";"g"))
    else
      error("Invalid JSON Pointer: \($pointer)")
    end
  end
;

def pointer_get(tokens):
  reduce (tokens | .[]) as $token (
    .;
    .[
      if type == "object" then
        $token
      elif type != "array" then
        empty
      elif $token|test("^0$|^[1-9][0-9]*$") then
        $token|tonumber
      else
        empty
        # error("expected array index in JSON Pointer, got \($token)")
      end
     ]
  )
;

def pointer(json_pointer):
  (json_pointer | pointer_tokens) as $tokens |
  pointer_get($tokens)
;
