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
        loopingImage.imgX = Math.round(loopingImage.imgWidth / 360 * CarControl.yaw);
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
      }

      focus: true // To catch keypresses, an element must have active focus
      // This also means that all our rotation/movement handling must be done inside this
      Keys.onPressed:
          (event) => {
            switch (event.key) {
              case Qt.Key_A:
                steeringWheel.rotation -= 5;
                CarControl.changeYaw(1);
                break;
              case Qt.Key_D:
                steeringWheel.rotation += 5;
                CarControl.changeYaw(-1);
                break;
              case Qt.Key_S:
                stick.y += 5;
                CarControl.changePitch(1);
                break;
              case Qt.Key_W:
                stick.y -= 5;
                CarControl.changePitch(-1);
                break;
            }
          }
    }
}
