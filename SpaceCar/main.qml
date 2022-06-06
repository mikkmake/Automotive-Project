import QtQuick
// import SpaceCar
import SpaceCar
import QtQuick.Controls

Window {
    id: window
    width: 1400
    height: 980
    visible: true
    title: qsTr("SpaceCar")

    LoopingImage {
      imageSource: "images/Stars_quadrants.png"
    }
    Image {
      source: "images/Interior-background_alpha_smaller.png"
      SteeringWheel {
        id: steeringWheel
        x: 150
        y: (window.height / 2) - (height / 2) - 20
      }
    }
}
