
--[[ Copy & Run entire script in command bar after running PythonScript on your computer ! ]]
--[[ choose the output.bin in the same location as your script.py when asked... ]]

local studioservice = game:GetService("StudioService")

local bands = 280 --[[ change this value to match py script ]]

--[[ destination where output data will be placed in your game! (change this if you moved it!)]]
local destination = game.ReplicatedStorage.FreqSeqs

warn("LOADING!")

local file = studioservice:PromptImportFile({"bin"})
local bin = file:GetBinaryContents()

local data = {}

for sample in string.gmatch(bin, string.rep("....", bands)) do
	local i = #data + 1
	data[i] = {}
	for bytes in string.gmatch(sample, "....") do
		local float = string.unpack("f", bytes)
		table.insert(data[i], float)
	end
end

local limit = 199999

local total_samples = #data
local sample_length = bands * 22 + 2
local chunk_length = math.floor(limit/sample_length)
local chunks = math.ceil(total_samples/chunk_length)

print("TOTAL SAMPLES", total_samples)
print("CHUNK LENGTH", chunk_length)
print("CHUNKS", chunks)

for i,v in pairs(destination:GetChildren()) do
	v:Destroy()
end

local output_buffer = ""

for chunk=1, chunks, 1 do
	for i=1, chunk_length, 1 do
		local sample = data[i + chunk_length*(chunk-1)]

		if sample then
			output_buffer = output_buffer..string.format("{%s},", table.concat(sample, ", "))
		end
	end

	output_buffer = string.format("return {\n%s\n}", output_buffer)

	local container = Instance.new("ModuleScript")
	container.Name = chunk
	container.Source = output_buffer
	container.Parent = destination

	output_buffer = ""

	wait()
end

warn("DONE!")
