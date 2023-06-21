# RBXLua_Audio_Visualizer

Working and fairly performant audio visualizer in RBXLua for publication on roblox.com.

Don't dis my choice of music.

Video:


https://github.com/PeachDoughnut/RBXLua_Audio_Visualizer/assets/135571737/d7e64e58-9a68-4c0c-a8bc-09e2b1fdee7a



The two scripts:

1. RBXLua_Importer.lua
2. Python_Converter.py

are command-line scripts. 1. is meant to run in the Roblox RBXLua runtime, and 2. runs in any old python on your computer. Read the comments, they are to setup the audio data for visualizing in command-line.

Scripts are to be placed in appropriate locations, for example: "ReplicatedStorage.Subtitles.lua" is a script named "Subtitles" (we drop the .lua in roblox) and child to the "ReplicatedStorage" object. Please see releases for a functional product.


TODO:
-About the "fairly performant" bit, UDim2 data objects could be baked in-advance of runtime, and played through frame-by-frame for extra performance boost.
