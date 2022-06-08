# Automotive-Project
Projectwork for Automotive Code Pro Now 2022

Directory "SpaceCar" contains the project. Within "code" is just a testing grounds.

Latest screenshot from ./documentation/Images/

<img src="documentation/Images/Screenshot0806.png"></img>

## 07. & 08.06.

Battled with LoopingImage to make it work first alone, then in the project use-case. I dread it will break at some point or not bend to the requirements of other features.

## 06.06.

Updated interior design.

## 03.06.

Have graphics ready to go and an initial layout. Star graphics are public domain, car-interior graphics <a href="http://www.freepik.com">Designed by macrovector / Freepik</a>

## 01.06.
Test in class

## 30.05.
Test commit

# Catalogue of Failures

## 08.06.

Accidental recursion: changing a property value inside the signal handler triggered by it's change. It's not the first time either.

## 4.6.

I spent a good 30 minutes figuring out why I wasn't receiving the onYawChanged and onPitchSignal in QML from a C++ defined Q_PROPERTY.

Attempted solution: Look at examples, search the web furiously.

Actual solution: Notice you only emit the signals if the "engine" is turned ON. By default it is turned OFF and you yourself scraped the ability to switch it by removing the power-button yesterday.

Also spent a good time thinking what's wrong with LoopingImage after updating the background image. Problem was not the component, problem was GIMP screwed the updated image.
