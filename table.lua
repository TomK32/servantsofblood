
function table.includes(self, element)
  for i, e in ipairs(self) do
    if e == element then
      return true
    end
  end
  return false
end
