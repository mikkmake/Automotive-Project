import QtQuick
import QtQuick.Controls
import SpaceCar

Item {
  // Don't have graphics yet. Probably have to draw them myself. So for now it's just two buttons
  id: root
  width: 100; height: 50
  Column {
    anchors.fill: parent
    Button {
      id: pitchUpButton
      text: "Pitch Up"
      onClicked: {
        console.log("Pitch Up pressed")
        CarControl.increasePitch()
      }
    }
    Button {
      id: pitchDownButton
      text: "PitchDown"
      onClicked: {
        console.log("Pitch Down pressed")
        CarControl.decreasePitch()
      }
    }
  }
}
