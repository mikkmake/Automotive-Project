
/* Component LoopingImage: intended for an infinitely scrolling view or background image
  How to use:
    -use an image that consists of 4 identical quadrants
    -the maximum viewPort size is one quadrant
    -control image position within viewport through imgX & imgY
*/
import QtQuick

Rectangle {
  id: viewPort // more instructive name than root?
  required property string imageSource
  // Alias image coordinates for use outside component
  property alias imgX: viewImage.x
  property alias imgY: viewImage.y
  property alias imgWidth: viewImage.width
  property alias imgHeight: viewImage.height
  // These placeholders are the maximum dimensions to get expected behavior
  width: viewImage.width / 2
  height: viewImage.height / 2
  clip: true
  Image {
    id: viewImage
    source: imageSource
    // Define the looping behavior
    onXChanged: () => {
                  if (x > 0)
                  x -= width / 2
                  else if (x < -width / 2)
                  x += width / 2
                }
    onYChanged: () => {
                  if (y > 0)
                  y -= height / 2
                  else if (y < -height / 2)
                  y += height
                }
  }
}
