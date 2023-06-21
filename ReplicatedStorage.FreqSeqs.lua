local data = {}

local children = script:GetChildren()

for ichunk=1, #children, 1 do
	local chunk = require(script:WaitForChild(""..ichunk))
	for i,v in pairs(chunk) do
		table.insert(data, v)
	end
end

return data