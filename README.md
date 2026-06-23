# Lua format string

String interpolation with support for table field lookups.

```lua
local f = require('f')

local person = { priv = { age = 27 } }
local name = 'Alex'

do
  local name = 'Urii'
  print(f'Name: ${name} | Person age: ${person.priv.age}') -- Name: Urii | Person age: 27
end
```

Variables are resolved from the current lexical scope, and nested table fields can be accessed using dot notation.

## Alternatives
  * [fstring via gsub](https://gist.github.com/uriid1/2b7823c096b3a697ceab7f40b4ccc54b)
  * [fdiv via mt](https://gist.github.com/uriid1/57356bf8618d78587f2f8515d8b2ab0f)
