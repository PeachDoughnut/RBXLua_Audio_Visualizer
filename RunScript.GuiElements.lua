
local Gui = function(Gui)
	local elements = {}
	
	elements.baseline = Gui:WaitForChild("baseline")
	elements.subtitles = Gui:WaitForChild("SubtitleText")
	elements.language = Gui:WaitForChild("LanguageButton")
	elements.StartButton = Gui:WaitForChild("StartButton")
	elements.fullscreen = Gui:WaitForChild("FullscreenText")
	elements.artist = Gui:WaitForChild("ArtistText")
	elements.title = Gui:WaitForChild("TitleText")

	elements.topbar = Gui:WaitForChild("TopFrame")
	elements.bottombar = Gui:WaitForChild("BottomFrame")
	
	return elements
end



return Gui
