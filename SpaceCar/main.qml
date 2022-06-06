import QtQuick
// import SpaceCar
import SpaceCar
import QtQuick.Controls

Window {
    width: 1400
    height: 980
    visible: true
    title: qsTr("SpaceCar")

    // For testing purposes, text-displays values
    // Row {
      // id: indicatorRow
      // anchors.horizontalCenter: parent.horizontalCenter
      // spacing: 5
      // Text {
        // text: "turnedOn: " + CarControl.turnedOn
      // }
      // Text {
        // text: "yaw: " + CarControl.yaw
      // }
      // Text {
        // text: "pitch: " + CarControl.pitch
      // }
      // Text {
        // text: "velocity: " + CarControl.velocity
      // }
    // }

    // How the application should actually look:
    // 	Movable background
    //		Car Interior background
    //			Dashboard
    //				Steering Wheel
    //				Gear Stick
    //				Info Screen and all the rest
    LoopingImage {
      imageSource: "Stars_quadrants.png"
    }
    Image {
      source: "Interior-background_alpha_smaller.png"
    }
}
