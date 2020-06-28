getmetatable("").__mod = function(s, tab)
  return (s:gsub('($%b{})', function(w) return tostring(tab[w:sub(3, -2)]) or tostring(w) end))
end

