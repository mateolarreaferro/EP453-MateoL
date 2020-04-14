# README EP-453-MLF
1. Project Name:
Problem Set 10

2. Submitted by:
Mateo Larrea

3. For Course:
EP-453

4. Due Date:
9:00:00 AM on 4/14/2020

5. Submission Date/Hour:
1:25:00 AM on 4/14/2020

6. Files Included:
* README.md
* Visualizer.xcodeproj
* ViewController.swift
* Spectroscope.swift
* Synth.swift 



7. Purpose:
The purpose of PS10 was to use Audiokit's framework to create an application that generated white noise and its corresponding visual representation based on a microphone input. We learned about FFTTap, drawing frequency domain data, and checking for headphones input. Many of this concepts are very useful for future iOS applications. 

8. Description:
The Problem Set divided into two different sections: (1) Creating an AKNode configuration that consisted on: KWhiteNoise -> AKResonantFilter * 10 -> AKMixer -> AKReverb. (The 10 AKResonantFilters increades its cutoff frequencies in a linear scale). And then (2), dividng the screen into 10 sections that allowed different controls in relation to those filters. 

My code: Things to resolve
Oposed to AKLowPassFilter, AKResonantFilter didn't contain the parameter required in the instructions (resonance and cutoff frequency). --> I replaced the resonance with bandwidth  

I need to find a precise way of calculating the cutoff frequency of the filters that is gradually increasing. This inclused familiarizing myself with "Nyquist frequencies".  --> I devided the last filter value into 10 and added 2000 for each increasing filter

Things that are not included:

1. Each horizontally-divided segment should then control the volume of each AKResonantFilter in the AKMixer when the user touches the screen.

2. The y-axis value from the pan gesture should control the volume for each AKResonantFilter.

3. Make sure to visualize the output of AKMixer for the spectroscope so that we see all ten filters visualized.

9. Dependencies
Frameworks AudioKit



