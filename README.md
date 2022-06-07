# Automotive-Project
Projectwork for Automotive Code Pro Now 2022

## 03.06

Have graphics ready to go and an initial layout. Star graphics are public domain, car-interior graphics <a href="http://www.freepik.com">Designed by macrovector / Freepik</a>

## 01.06.
Test in class

## 30.05.
Test commit

# Catalogue of Failures

## 4.6.

I spent a good 30 minutes figuring out why I wasn't receiving the onYawChanged and onPitchSignal in QML from a C++ defined Q_PROPERTY.
Attempted solution: Look at examples, search the web furiously.
Actual solution: Notice you only emit the signals if the "engine" is turned ON. By default it is turned OFF and you yourself scraped the ability to switch it by remobing the power-button yesterday.
