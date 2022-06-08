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
      animationDuration: 10
      // Connect CarControl orientation to background movement in a sensible way
      // If one quadrant corresponds to 360-degrees, a degree should correspond to width / 360
      // and height / 360
      Connections {
       target: CarControl
       onYawChanged:
       (change) => {
        loopingImage.moveX(Math.round(-loopingImage.imgWidth / 2 / 360.0 * change));
        console.log("X changed by " + change + " to " + loopingImage.targetX);
       }
       onPitchChanged:
       (change) => {
        console.log("catched pitchChanged signal with " + change);
        // loopingImage.imgY = Math.round(-loopingImage.imgHeight / 2 / 360 * CarControl.pitch);
        loopingImage.moveY(Math.round(-loopingImage.imgHeight / 2 / 360 * change));
        console.log("Y changed by " + loopingImage.targetY);
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
          interval: 10
          onTriggered: {
            steeringWheel.rotation += 1;
            CarControl.changeYaw(1);
          }
        }
        Timer {
          id: yawDecreaseTimer
          repeat: true
          interval: 10
          onTriggered: {
            steeringWheel.rotation -= 1;
            CarControl.changeYaw(-1);
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
//        Limit movement
        BoundaryRule on y {
          minimum: interior.height - stick.height
          maximum: interior.height - stick.height + 40
        }
        // Control timers
        Timer {
          id: pitchDecreaseTimer
          interval: 10
          repeat: true
          onTriggered: {
            stick.y += 1;
            CarControl.changePitch(-1);
          }
        }
        Timer {
          id: pitchIncreaseTimer
          interval: 10
          repeat: true
          onTriggered: {
            stick.y -= 1;
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
            accelerationTimer.running = true;
          }
          if (event.key === Qt.Key_Shift) {
            deccelerationTimer.running = true;
          }
          if (event.key === Qt.Key_A) {
            yawDecreaseTimer.running = true;
          }
          if (event.key === Qt.Key_D) {
            yawIncreaseTimer.running = true;
          }
          if (event.key === Qt.Key_S) {
            pitchDecreaseTimer.running = true;
          }
          if (event.key === Qt.Key_W) {
            pitchIncreaseTimer.running = true;
          }
        }
      Keys.onReleased:
        (event) => {
          if (event.isAutoRepeat)
            return;
          if (event.key === Qt.Key_Space) {
            // Stop acceleration increase
            accelerationTimer.running = false;
          }
          if (event.key === Qt.Key_Shift) {
            deccelerationTimer.running = false;
          }
          if (event.key === Qt.Key_A) {
            yawDecreaseTimer.running = false;
          }
          if (event.key === Qt.Key_D) {
            yawIncreaseTimer.running = false;
          }
          if (event.key === Qt.Key_S) {
            pitchDecreaseTimer.running = false;
          }
          if (event.key === Qt.Key_W) {
            pitchIncreaseTimer.running = false;
          }
        }
    }
  }
