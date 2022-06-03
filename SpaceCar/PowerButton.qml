import QtQuick 2.0

Item {
  id: root
  property bool turnedOn: false
  width: 200; height: width
  Image {
      anchors.fill: parent
      antialiasing: true
      source: turnedOn ? "power_button_on.png" : "power_button_off.png"
      MouseArea {
          anchors.fill: parent
          onClicked: turnedOn = !turnedOn
      }
  }
}
