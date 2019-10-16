import QtQuick 2.3
import "./"


Rectangle {
    x: 0
    y: 0
    width: parent.width
    height: 25
    color: "transparent"

    property var win: Object

    Label {
        id: btnClose
        anchors.top: parent.top
        anchors.topMargin: 7
        anchors.right: parent.right
        anchors.rightMargin: 8
        text: "\uf410"
        font.family: "Font Awesome 5 Free"
        size: 10
        opacity: 0.8
        z: 99

        MouseArea {
            anchors.fill: parent
            onClicked: {
                win.close()
            }
        }
    }

    Label {
        id: btnMin
        x: btnClose.x - width - 15
        y: btnClose.y
        text: "\uf2d1"
        font.family: "Font Awesome 5 Free"
        size: 10
        opacity: 0.8
        z: 99

        MouseArea {
            anchors.fill: parent
            onClicked: {
                win.showMinimized()
            }
        }
    }

    Label {
        id: btnMax
        x: btnMin.x - width - 15
        y: btnMin.y + 1
        text: "\uf2d0"
        font.family: "Font Awesome 5 Free"
        size: 10
        opacity: 0.8
        z: 99

        MouseArea {
            anchors.fill: parent
            property bool maximezed: true

            onClicked: {
                if (maximezed) {
                    win.showMaximized()
                } else {
                    win.showNormal()
                }
                maximezed = !maximezed
            }
        }
    }
}
