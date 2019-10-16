//contents of App.qml
import QtQuick 2.7
import QtQuick.Controls 1.2
import "./"


ApplicationWindow {
    id: main
    visible: true
    width: 900
    height: 600
    title: qsTr("App")

    property alias fontIcons: fontIcons
    property alias focus: wm

    FontLoader { id: fontIcons; name: "Font Awesome 5 Free"; source: "fontawesome-free-5.0.10/web-fonts-with-css/webfonts/fa-solid-900.woff" }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            wm.focus = true
        }
    }

    FocusScope {
        id: wm
        x: 0
        y: 0
        width: parent.width
        height: parent.height
    }
}
