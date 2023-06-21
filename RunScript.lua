
--TODO: 11/16/(2022?): Bake the scales for optimization.

print("Version 1.1.5 - 'optimization 1.1: cleaned-up code, Jun 20, 2023")

--Roblox Services:
local RunService =			game:GetService("RunService")
local TweenService =			game:GetService("TweenService")
local ReplicatedStorage =	game:GetService("ReplicatedStorage")
local InputService =			game:GetService("UserInputService")

local freqseqs = require(ReplicatedStorage:WaitForChild("FreqSeqs"))
local total_samples = #freqseqs

local subdata = require(ReplicatedStorage:WaitForChild("Subtitles"))

local config = require(script:WaitForChild("Configuration"))

local music = script:WaitForChild("Music")

local Gui = script.Parent
local GuiElements = require(script:WaitForChild("GuiElements"))(Gui)

----------

local ismobile = (InputService.AccelerometerEnabled or InputService.GyroscopeEnabled) or not InputService.KeyboardEnabled

local plr = game:GetService("Players").LocalPlayer
local plrgui = plr:WaitForChild("PlayerGui")

local mouse = plr:GetMouse()

RunService:UnbindFromRenderStep("loadinggui")

----------
--very sloppy, needs an automated keyframing system for animating things like this... (2023 note: wasn't made due to it being a distraction to go onto developing a full, separate system)
--animated loading screen:
local backgui = plrgui:WaitForChild("BackgroundGui", 2)
if backgui then
	local backtop = backgui:WaitForChild("TopFrame")
	local backbottom = backgui:WaitForChild("BottomFrame")

	local artframe = backgui:WaitForChild("ArtworkFrame")
	local artwork = artframe:WaitForChild("Artwork")

	local artleft = artwork:WaitForChild("Left")
	local artright = artwork:WaitForChild("Right")

	local artframetween = TweenService:Create(artframe, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {BackgroundTransparency = 1})
	local artLtween = TweenService:Create(artleft, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {ImageTransparency = 1})
	local artRtween = TweenService:Create(artright, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {ImageTransparency = 1})

	artframetween:Play()
	artLtween:Play()
	artRtween:Play()

	artwork:WaitForChild("dummyLeft").Visible = false

	local backtoptween = TweenService:Create(backtop, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Position = UDim2.new(0,0,0,-backtop.AbsoluteSize.Y)})
	local backbottomtween = TweenService:Create(backbottom, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Position = UDim2.new(0,0,1,0)})

	backtoptween:Play()
	backbottomtween:Play()

	backgui:WaitForChild("LoadingText"):Destroy()
end
----------

--skybox:
local skybox = ReplicatedStorage:WaitForChild("SkyboxGui"):Clone()
local skyviewport = skybox:WaitForChild("SkyboxViewport")
local skycam = Instance.new("Camera")
skycam.Parent = skyviewport

skyviewport.CurrentCamera = skycam

local skydist = CFrame.new(0, 0, -1000)

function resizeskybox()
	local cam = workspace.CurrentCamera
	skybox.Size = UDim2.new(0, cam.ViewportSize.X, 0, cam.ViewportSize.Y)
end

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
	resizeskybox()
end)

resizeskybox()

--subtitles:
local subcontext = {
	[1] = {"EN", "Fullscreen", "Music"},
	[2] = {"JP", "フルスクリーン", "音"},
	[3] = {"OFF", "Fullscreen", "Music"}
}

local subsize = {
	[1] = 56,
	[2] = 78,
	[3] = 40
}

local submode = 1

if ismobile then
	GuiElements.fullscreen.Visible = false
	
	subsize[1] = 38
	subsize[2] = 50
	subsize[3] = 30
	
	GuiElements.language.Position = UDim2.new(0, 55, 0, 5)
	
	GuiElements.topbar.Size = UDim2.new(1,0,0,65)
	GuiElements.bottombar.Size = UDim2.new(1,0,0,75)
	GuiElements.bottombar.Position = UDim2.new(0,0,1,-75)
	
	GuiElements.title.Position = UDim2.new(1, -135, 0, 20)
	GuiElements.artist.Position = UDim2.new(1, -25, 0, 45)
	
	config.band_samples = 1
	config.amp_height = 4750
end

----------

--final, main runtime stuff:
local triangle = script:WaitForChild("Triangle")
local rectangle = script:WaitForChild("Rectangle")
local gradient = script:WaitForChild("UIGradient")
local gradientcuttoff = 400

local floor = math.floor
local ceil = math.ceil
local abs = math.abs
local min = math.min
local max = math.max

function round(n)
	local nfloor = floor(n)
	if (n - nfloor) < 0.5 then
		return nfloor
	else
		return ceil(n)
	end
end

function start()
	mouse.Icon = "rbxasset://SystemCursors/Cross"
	
	local tris = {}
	local rects = {}
	
	for sample=1, config.band_samples, 1 do --sample 1 being the first, frontmost sample.
		tris[sample] = {}
		rects[sample] = {}
		
		for i=1, config.bands-1, 1 do
			local fraction = i/(config.bands-1)
			
			local color1 = Color3.fromHSV(0.666667 - (fraction) * (0.666667 - 0.5), 0.5 + fraction * 0.5, 1)
			--local color2 = Color3.fromHSV(0.666667 - (fraction) * (0.666667 - 0.5), 1 - fraction * 0.5, 0.5 + fraction * 0.5)
			local color3 = Color3.fromHSV(0.666667 - (fraction) * (0.666667 - 0.5), 0.5 + fraction * 0.5, 1 - 0.5 * (sample-1)/(config.band_samples-1))
			
			local colorcombined = color1:lerp(color3, (sample-1)/(config.band_samples-1))
			local transparency = ((sample-1)/(config.band_samples-1)) * 0.75
			
			if config.band_samples == 1 then
				colorcombined = color1
				transparency = 0
			end
			
			--2023 note: I commented out sections where I experimented with adding an optional, "gradient" visual effect.
			
			tris[sample][i] = {triangle:Clone(), triangle:Clone()}--, gradient:Clone()} --up, down
			tris[sample][i][1].ImageColor3 = colorcombined
			tris[sample][i][1].ImageTransparency = transparency
			tris[sample][i][1].ZIndex = 10+config.band_samples-sample
			
			tris[sample][i][2].ImageColor3 = colorcombined
			tris[sample][i][2].ImageTransparency = transparency
			tris[sample][i][2].ZIndex = 10+config.band_samples-sample
			
			--tris[sample][i][3].Color = ColorSequence.new()
			--tris[sample][i][3].Parent = tris[i][2]
			
			tris[sample][i][1].Parent = GuiElements.baseline
			tris[sample][i][2].Parent = GuiElements.baseline
			
			
			rects[sample][i] = {rectangle:Clone()}--, gradient:Clone()}
			rects[sample][i][1].BackgroundColor3 = colorcombined
			rects[sample][i][1].BackgroundTransparency = transparency
			rects[sample][i][1].ZIndex = 10+config.band_samples-sample
			
			--rects[sample][i][2].Color = ColorSequence.new()
			--rects[sample][i][2].Parent = rects[i][1]
			
			rects[sample][i][1].Parent = GuiElements.baseline
		end
	end
	
	music:Play()
	
	local subindex = 1
	
	local f = 1
	local t = 0
	--local t0 = tick()
	
	local function updatesubs()
		local cursubdata = subdata[subindex]
		
		if cursubdata then
			if t >= cursubdata[1] then
				if t <= cursubdata[2] then
					GuiElements.subtitles.TextSize = subsize[submode] or 0
					GuiElements.subtitles.Text = cursubdata[2 + submode] or ""
				else
					subindex = subindex + 1
					
					GuiElements.subtitles.Text = ""
					
					updatesubs()
				end
			end
		end
	end
	
	local skytweenin = TweenService:Create(skyviewport, TweenInfo.new(12, Enum.EasingStyle.Linear,Enum.EasingDirection.In), {Ambient = Color3.fromRGB(185, 210, 255)})
	skytweenin:Play()
	
	skybox.Parent = plrgui
	
	RunService:BindToRenderStep("musicvisualizer", Enum.RenderPriority.Last.Value, function()
		if not music.IsPlaying then
			music:Play()
			subindex = 1
		end
		
		--2023 note: alternative time-tracking method. Replaced in favour of trusting Roblox's audio engine with t=music.TimePosition instead of t0 and lua's tick().
		
		t = music.TimePosition--t = tick() - t0
		f = round(t * config.frame_rate)--+1
		
		--if f >= total_samples then
		--	--t0 = tick()
		--	--t = tick() - t0
		--	music:Stop()
		--	music:Play()
			
		--	t = music.TimePosition
		--	f = floor(t * frame_rate)--+1
			
		--	subindex = 1
		--end
		
		local cam = workspace.CurrentCamera
		local camcf = cam.CFrame
		
		skybox.StudsOffsetWorldSpace = (camcf * skydist).p
		skycam.CFrame = camcf - camcf.p
		
		updatesubs()
		
		for isample=1, config.band_samples, 1 do
			local points = {}
			
			local sample = freqseqs[f-(isample+1)]
			
			if sample then
				for i=1, config.bands, 1 do
					local amp = sample[i] * config.amp_height
					
					points[i] = amp*-0.5
				end
			else
				for i=1, config.bands, 1 do
					points[i] = 0
				end
			end
			
			for i,tri in pairs(tris[isample]) do
				local triup = tri[1]
				local tridown = tri[2]
				--local trigradient = tri[3]
				
				local rect = rects[isample][i]
				
				local rectcenter = rect[1]
				--local rectgradient = rect[2]
				
				local x = config.band_width*(i-1)
				
				local y1 = points[i]
				local y2 = points[i+1]
				
				local ymax = round(max(y1,y2)) --keep in mind, 'max' is lower and 'min' is higher
				local ymin = round(min(y1,y2))
				
				local ytri = ymax-ymin
				
				triup.Size = UDim2.new(config.band_width, 0, 0, ytri)
				triup.Position = UDim2.new(x, 0, 0, ymin)
				
				tridown.Size = UDim2.new(config.band_width, 0, 0, ytri)
				tridown.Position = UDim2.new(x, 0, 0, -ymin-ytri)
				
				if y2 > y1 then
					triup.Image = "http://www.roblox.com/asset/?id=5653274996"
					tridown.Image = "http://www.roblox.com/asset/?id=5267020084"
				else
					triup.Image = "http://www.roblox.com/asset/?id=5653275177"
					tridown.Image = "http://www.roblox.com/asset/?id=6562299427"
				end			
				
				--2023 note: I had commented out updating the experimental "gradient" effect objects from earlier in this start() function.
				
				--rectup.Size = UDim2.new(band_width, 0, 0, ymax)
				--rectup.Position = UDim2.new(x, 0, 0, 0)
				
				--rectdown.Size = UDim2.new(band_width, 0, 0, ymax)
				--rectdown.Position = UDim2.new(x, 0, 0, -ymax)
				
				rectcenter.Size = UDim2.new(config.band_width, 0, 0, ymax*2)
				rectcenter.Position = UDim2.new(x, 0, 0, -ymax)
				
				--local gradclipping = min(ymin + gradientcuttoff, 0)
				
				--local gradratio = ymax/ymin
				--local gradfraction = gradclipping * gradratio
				
				--rectgradient.Transparency = NumberSequence.new({
				--	NumberSequenceKeypoint.new(0, 0),
				--	NumberSequenceKeypoint.new(1, gradclipping/ymin)
				--})
				
				--trigradient.Transparency = NumberSequence.new({
				--	NumberSequenceKeypoint.new(0, gradclipping/ymin),
				--	NumberSequenceKeypoint.new(1, 1)
				--})
			end
		end
	end)
end

local playing = false

GuiElements.StartButton.MouseButton1Click:Connect(function()
	if not playing then
		playing = true
		GuiElements.StartButton.Visible = false
		start()
	end
end)

GuiElements.language.MouseButton1Click:Connect(function()
	submode = submode+1
	if submode > #subcontext then
		submode = 1
	end
	local languagedata = subcontext[submode]
	
	GuiElements.language.Text = string.format("ぁ・a : %s", languagedata[1])
	GuiElements.fullscreen.Text = string.format("<b>[F11]</b>: %s", languagedata[2])
	GuiElements.artist.Text = string.format("%s : オカメP", languagedata[3])
end)
