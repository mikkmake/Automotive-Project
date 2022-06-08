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
        console.log("setting X to: " + Math.round(-loopingImage.imgWidth / 2 / 360.0 * CarControl.yaw));
        loopingImage.imgX = Math.round(-loopingImage.imgWidth / 2 / 360.0 * CarControl.yaw);
        console.log("X set to " + loopingImage.imgX);
       }
       onPitchChanged: {
        console.log("catched pitchChanged signal with " + CarControl.pitch);
        loopingImage.imgY = Math.round(-loopingImage.imgHeight / 2 / 360 * CarControl.pitch);
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
        z: 1
        Timer {
          id: yawIncreaseTimer
          repeat: true
          interval: 100
          onTriggered: {
            steeringWheel.rotation += 5;
            CarControl.changeYaw(5);
          }
        }
        Timer {
          id: yawDecreaseTimer
          repeat: true
          interval: 100
          onTriggered: {
            steeringWheel.rotation -= 5;
            CarControl.changeYaw(-5);
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
        // BoundaryRule on y {
          // minimum: interior.height - stick.height
          // maximum: interior.height - stick.height + 40
        // }
        // Control timers
        Timer {
          id: pitchDecreaseTimer
          interval: 100
          repeat: true
          onTriggered: {
            stick.y += 5;
            CarControl.changePitch(-5);
          }
        }
        Timer {
          id: pitchIncreaseTimer
          interval: 100
          repeat: true
          onTriggered: {
            stick.y -= 5;
            CarControl.changePitch(5);
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
      GasPedal {
        id: gasPedal
        x: 480
        anchors {
          top: parent.verticalCenter
          topMargin: 155
        }
        Timer {
          id: accelerationTimer
          interval: 100
          repeat: true
          onTriggered: {
            CarControl.changeAcceleration(0.1);
          }
        }
      }
      BrakePedal {
        id: brakePedal
        x: 350
        anchors {
          verticalCenter: parent.verticalCenter
          verticalCenterOffset: 155
        }
        Timer {
          id: deccelerationTimer
          interval: 100
          repeat: true
          onTriggered: {
            CarControl.changeAcceleration(-0.1);
          }
        }
      }

      // Only the element with focus can take input -> everything handled here
      focus: true
      Keys.onPressed:
        (event) => {
          // Disable autorepeat on all
          if (event.isAutoRepeat)
            return;
          if (event.key === Qt.Key_Space) {
            console.log("Spacebar detected");
            accelerationTimer.running = true;
            // Begin acceleration increase
          }
          if (event.key === Qt.Key_Shift) {
            console.log("Shift detected");
            deccelerationTimer.running = true;
          }
          if (event.key === Qt.Key_A) {
            console.log("Key_A detected");
            yawDecreaseTimer.running = true;
          }
          if (event.key === Qt.Key_D) {
            console.log("Key_D detected");
            yawIncreaseTimer.running = true;
          }
          if (event.key === Qt.Key_S) {
            console.log("Key_S detected");
            pitchDecreaseTimer.running = true;
          }
          if (event.key === Qt.Key_W) {
            console.log("Key_W detected");
            pitchIncreaseTimer.running = true;
          }
        }
      Keys.onReleased:
        (event) => {
          if (event.isAutoRepeat)
            return;
          if (event.key === Qt.Key_Space) {
            console.log("Spacebar released");
            // Stop acceleration increase
            accelerationTimer.running = false;
          }
          if (event.key === Qt.Key_Shift) {
            console.log("Shift released");
            deccelerationTimer.running = false;
          }
          if (event.key === Qt.Key_A) {
            console.log("Key_A released");
            yawDecreaseTimer.running = false;
          }
          if (event.key === Qt.Key_D) {
            console.log("Key_D released");
            yawIncreaseTimer.running = false;
          }
          if (event.key === Qt.Key_S) {
            console.log("Key_S released");
            pitchDecreaseTimer.running = false;
          }
          if (event.key === Qt.Key_W) {
            console.log("Key_W released");
            pitchIncreaseTimer.running = false;
          }
        }
    }
  }
