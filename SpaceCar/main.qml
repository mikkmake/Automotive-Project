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
      imageSource: "images/Stars_quadrants.png"
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
              case Qt.Key_D:
                steeringWheel.rotation += 5;
                loopingImage.imgX -= 5;
                break;
              case Qt.Key_A:
                steeringWheel.rotation -= 5;
                loopingImage.imgX += 5;
                break;
              case Qt.Key_S:
              console.log(stick.y);
                stick.y += 5;
                console.log(stick.y);
                loopingImage.imgY -=5;
                break
              case Qt.Key_W:
              console.log(stick.y);

                stick.y -= 5;
                console.log(stick.y);
                loopingImage.imgY += 5;
                break;
            }
          }
    }
}
