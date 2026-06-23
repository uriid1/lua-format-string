-- Upvalues test
--
local f = require('f')

local a = 'Hello'
local function fn()
  return function(b)
    local y = 2026
    print(f'${a}, ${b}! | Year: ${y}')
  end
end

fn()('World')
