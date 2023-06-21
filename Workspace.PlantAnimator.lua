
--2023: little script to animate plants in the workspace

local Plants = workspace:WaitForChild("Plants")

local plants1 = {}
for i,v in pairs(Plants:WaitForChild("1"):GetChildren()) do
	plants1[v.Name] = v
end

local plants2 = {}
for i,v in pairs(Plants:WaitForChild("2"):GetChildren()) do
	plants2[v.Name] = v
end

local states = {
	["Flower"] = 0.85,
	["Grass"] = 0.8,
	["Grass2"] = 0.9
}

local bps = 140/60
local steps = 50

local delaytime = (3/bps)
local waittime = (1/bps)/steps

function animate()
	for step=1, steps, 1 do
		for name,val in pairs(states) do
			plants1[name].Transparency = 1 - (1-(step-1)/(steps-1)) * (1-val)
			plants2[name].Transparency = 1 - (step-1)/(steps-1) * (1-val)
		end
		wait(waittime)
	end
	wait(delaytime)
	for step=steps, 1, -1 do
		for name,val in pairs(states) do
			plants1[name].Transparency = 1 - (1-(step-1)/(steps-1)) * (1-val)
			plants2[name].Transparency = 1 - (step-1)/(steps-1) * (1-val)
		end
		wait(waittime)
	end
	wait(delaytime)
	animate()
end

animate()