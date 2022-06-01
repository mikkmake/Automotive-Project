import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Rectangle {
        anchors.centerIn: parent
        width: 200; height: width
        color: "red"
        Text {
            anchors.centerIn: parent
            text: "Helou vöörldd"
            color: "black"
        }
    }
}
