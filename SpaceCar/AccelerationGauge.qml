import QtQuick
import QtQuick.Shapes
import SpaceCar

Image {
  id: root
  source: "images/AccelerationGauge.png"
  Shape {
    id: mask
    ShapePath {
      strokeColor: "#CC414042"
      fillColor: "transparent"
      strokeWidth: 27
      capStyle: ShapePath.FlatCap
      PathAngleArc {
        centerX: 100
        centerY: 125
        radiusX: 50
        radiusY: 50
        // Just want this to work to go to bed.....
        startAngle: -183 + ((145 / 5) * CarControl.acceleration)
        sweepAngle: 145 - ((145 / 5) * CarControl.acceleration)
      }
    }
  }
  Text {
    x: 85; y: 105
    text: CarControl.acceleration.toFixed(1) + " G"
    font.pixelSize: 16
  }
}
