
local Configuration = {}


Configuration.frame_rate = 30

Configuration.bands = 280--240
Configuration.band_samples = 2 --amount of samples that will render at once, gives a 'fade-y' effect

Configuration.band_width = 1/(Configuration.bands-1)

Configuration.amp_height = 6400



return Configuration
