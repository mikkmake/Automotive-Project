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
    // This controls both the tickrate of Yaw & Pitch change, and background animation duration. Change at your own peril
    property int bgAnimationDuration: 10

    // Moving background (out-of-windshield view)
    LoopingImage {
      id: loopingImage
      width: window.width
      height: window.height
      imageSource: "images/Stars_quadrants.png"
      animationDuration: bgAnimationDuration
      // Connect CarControl orientation to background movement in a sensible way
      Connections {
        target: CarControl
        function onYawChanged(change) {
          loopingImage.moveX(Math.round(-loopingImage.imgWidth / 2 / 360.0 * change));
        }
        function onPitchChanged(change) {
          loopingImage.moveY(Math.round(-loopingImage.imgHeight / 2 / 360 * change));
        }
      }
    }

    // Car interior begins
    Image {
      id: interior
      source: "images/Interior-background_alpha_smaller.png"
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
        // Pitch-control timers
        Timer {
          id: pitchDecreaseTimer
          interval: bgAnimationDuration
          repeat: true
          onTriggered: {
            stick.y += 1;
            CarControl.changePitch(-1);
          }
        }
        Timer {
          id: pitchIncreaseTimer
          interval: bgAnimationDuration
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
      SteeringWheel {
        id: steeringWheel
        x: 150
        y: (window.height / 2) - (height / 2) - 20
        // Yaw-control timers
        Timer {
          id: yawIncreaseTimer
          repeat: true
          interval: bgAnimationDuration
          onTriggered: {
            steeringWheel.rotation += 1;
            CarControl.changeYaw(1);
          }
        }
        Timer {
          id: yawDecreaseTimer
          repeat: true
          interval: bgAnimationDuration
          onTriggered: {
            steeringWheel.rotation -= 1;
            CarControl.changeYaw(-1);
          }
        }
      }
      YawGauge {
        x: 620
        y: 360
      }

      // Only the element with focus can take KB-input -> everything handled here
      focus: true
      Keys.onPressed:
        (event) => {
          // Disable autorepeat on all keys
          if (event.isAutoRepeat)
            return;
          switch (event.key) {
            case Qt.Key_Space: accelerationTimer.running = true; break;
            case Qt.Key_Shift: deccelerationTimer.running = true; break;
            case Qt.Key_A: yawDecreaseTimer.running = true; break;
            case Qt.Key_D: yawIncreaseTimer.running = true; break;
            case Qt.Key_S: pitchDecreaseTimer.running = true; break;
            case Qt.Key_W: pitchIncreaseTimer.running = true; break;
          }
        }
      Keys.onReleased:
          (event) => {
            if (event.isAutoRepeat)
            return;
            switch (event.key) {
              case Qt.Key_Space: accelerationTimer.running = false; break;
              case Qt.Key_Shift: deccelerationTimer.running = false; break;
              case Qt.Key_A: yawDecreaseTimer.running = false; break;
              case Qt.Key_D: yawIncreaseTimer.running = false; break;
              case Qt.Key_S: pitchDecreaseTimer.running = false; break;
              case Qt.Key_W: pitchIncreaseTimer.running = false; break;
            }
          }

    }
}
