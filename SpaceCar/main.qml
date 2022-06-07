import QtQuick
import SpaceCar
import QtQuick.Controls
import Qt.labs.animation

Window {
    id: window
    width: 1400
    height: 980
    visible: true
    title: qsTr("SpaceCar")

    LoopingImage {
      id: loopingImage
      // viewport height
      height: window.height
      imageSource: "images/Stars_quadrants.png"
      // Connect CarControl orientation to background movement in a sensible way
      // If one quadrant corresponds to 360-degrees, a degree should correspond to width / 360
      // and height / 360
      Connections {
       target: CarControl
       onYawChanged: {
        console.log("catched yawChanged signal with " + CarControl.yaw);
        loopingImage.imgX = Math.round(-loopingImage.imgWidth / 360 * CarControl.yaw);
        console.log("X set to " + loopingImage.imgX);
       }
       onPitchChanged: {
        console.log("catched pitchChanged signal with " + CarControl.pitch);
        loopingImage.imgY = Math.round(loopingImage.imgHeight / 360 * CarControl.pitch);
        console.log("Y set to " + loopingImage.imgY);
       }
       }
    }
    Image {
      id: interior
      source: "images/Interior-background_alpha_smaller.png"
      SteeringWheel {
        id: steeringWheel
        x: 150
        y: (window.height / 2) - (height / 2) - 20
        // Define control keys
        Shortcut {
          sequence: "A"
          onActivated: {
            steeringWheel.rotation -= 5;
            CarControl.changeYaw(-1);
          }
        }
        Shortcut {
          sequence: "D"
          onActivated: {
            steeringWheel.rotation += 5;
            CarControl.changeYaw(1);
          }
        }
      }
      PitchStick {
        id: stick
        y: interior.height - height + 20
        anchors {
          horizontalCenter: parent.horizontalCenter
          horizontalCenterOffset: 50
        }
        // Limit movement
        BoundaryRule on y {
          minimum: interior.height - stick.height
          maximum: interior.height - stick.height + 40
        }
        // Define control keys
        Shortcut {
          sequence: "W"
          onActivated: {
            stick.y -= 4;
            CarControl.changePitch(-1);
          }
        }
        Shortcut {
          sequence: "S"
          onActivated: {
            stick.y += 4;
            CarControl.changePitch(1);
          }
        }
      }
      InfoScreen {
        y: 500
        anchors {
          horizontalCenter: parent.horizontalCenter
          horizontalCenterOffset: 50
        }
      }

    }
  }
