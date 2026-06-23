-- Base test
--
local f = require('f')

local person = { priv = { age = 27 } }
local name = 'Alex'

do
  local name = 'Urii'
  print(f'Name: ${name} | Person age: ${person.priv.age}') -- Name: Urii | Person age: 27
end
