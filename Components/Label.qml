//contents of Label.qml
import QtQuick 2.3

Text {

    property alias size: label.font.pixelSize

    id: label
    text: "Option 1"
    horizontalAlignment: Text.horizontalCenter
    font.pixelSize: 26
    font.family: "roboto light"
    color: "#ffffff"
    antialiasing: true
}
