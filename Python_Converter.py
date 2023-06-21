
#-- Python script for importing audio data (save to a script.py on your computer and run!)

#-- Download necessary dependencies below using pip (python package installer) on cmd.exe
#-- Dependencies: librosa, numpy, scipy, struct

#-- Requires Python to be installed on your computer! (duh!)

import librosa
import numpy as np
import scipy.signal
import struct

bands = 280 #-- number of frequency bins (change for desired amount of bars!)
hop_length_secs = 1 / 30 #-- frame rate (30 FPS)

print("reading...")

y, sr = librosa.load("your_music.wav") #-- input file (in same folder as your_script.py)! (MUST BE .wav)
hop_length_samples = int(hop_length_secs * sr)

stft = np.abs(librosa.stft(y, n_fft=1024, hop_length=hop_length_samples))
num_bins, num_samples = stft.shape

#-- Resample to the desired number of frequency bins:
stft2 = np.abs(scipy.signal.resample(stft, bands, axis=0))
stft2 = stft2 / np.max(stft2) #-- Normalize to 0 to 1 (optional)

print("writing...")

output_file = open("output.bin", "wb")

for y in range(num_samples):
    for i in stft2[:, y]:
        float = i.item()
        output_file.write(struct.pack('f', float))

output_file.close()

print("DONE!!")
input()