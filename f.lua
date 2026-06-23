-- .-.-.-.-.-.-.-.-.-.-.-.-.-.
-- Module: Format string
-- Licence: MIT
-- (C) 2026 uriid1 <github.com/uriid1>
-- .-.-.-.-.-.-.-.-.-.-.-.-.-.

local function getLocalCount(stackLevel)
  local count = 0
  while debug.getlocal(stackLevel + 1, count + 1) do
    count = count + 1
  end
  return count
end

local function findLocalValue(stackLevel, varName)
  while debug.getinfo(stackLevel, '') do
    local localLevel = getLocalCount(stackLevel)
    repeat
      local name, value = debug.getlocal(stackLevel, localLevel)
      if name == varName then
        return value
      end

      localLevel = localLevel - 1
    until name == nil

    stackLevel = stackLevel + 1
  end
end

local function f(str)
  local env = _ENV or _G

  local fmtstr, _ = str:gsub('%${([%w_%.]+)}', function (varName)
    local isLookup = varName:find('%.') ~= nil
    local stackLevel = 4

    if not isLookup then
      local hasFindValue = findLocalValue(stackLevel, varName)
      if hasFindValue ~= nil then
        return tostring(hasFindValue)
      end

      return rawget(env, varName)
    end

    local tblName, lookup = varName:match('(.-)%.(.+)')
    local hasFindTable = findLocalValue(stackLevel, tblName)
    if type(hasFindTable) ~= 'table' then
      return nil
    end

    local look = hasFindTable
    for part in string.gmatch(lookup, '[^%.]+') do
      if look[part] ~= nil then
        look = look[part]
      end
    end

    return look
  end)

  return fmtstr
end

return f
