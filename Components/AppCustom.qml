//contents of App.qml
import QtQuick 2.9
import QtQuick.Controls 2.2
import "./"


ApplicationWindow {
    id: main
    visible: true
    width: 900
    height: 600
    title: qsTr("App")

    property alias fontIcons: fontIcons
    property alias focus: wm

    FontLoader { id: fontIcons; name: "Font Awesome 5 Free"; source: "fontawesome-free-5.0.10/web-fonts-with-css/webfonts/fa-regular-400.ttf" }

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

    Rectangle {
            id: resizeLeft
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            width: 6
            z: 999
            color: "transparent"

            MouseArea {
                anchors.fill: parent
                property int startX: 0
                property int startW: 0
                property bool _pressed: true

                hoverEnabled: true

                onEntered: {
                    cursorShape = Qt.SizeHorCursor
                }

                onExited: {
                    cursorShape = Qt.ArrowCursor
                }

                onPressedChanged: {
                    _pressed = !_pressed
                    startX = main.x
                    startW = main.width
                }

                onMouseXChanged: {
                    if (!_pressed) {

                        main.x = Context.mouseX() - 3

                        if (startX >= Context.mouseX()) {
                            main.width = startW + (startX - Context.mouseX())
                        } else {
                            main.width = startW - (Context.mouseX() - startX)
                        }
                    }
                }
            }
        }

        Rectangle {
            id: resizeRight
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            width: 6
            z: 999
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                property bool _pressed: true

                hoverEnabled: true

                onEntered: {
                    cursorShape = Qt.SizeHorCursor
                }

                onExited: {
                    cursorShape = Qt.ArrowCursor
                }

                onPressedChanged: {
                    _pressed = !_pressed
                }

                onMouseXChanged: {
                    if (!_pressed) main.width = Context.mouseX() - (main.x - 3)
                }
            }
        }

        Rectangle {
            id: resizeBottom
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            height: 6
            z: 999
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                property bool _pressed: true

                hoverEnabled: true

                onEntered: {
                    cursorShape = Qt.SizeVerCursor
                }

                onExited: {
                    cursorShape = Qt.ArrowCursor
                }

                onPressedChanged: {
                    _pressed = !_pressed
                }

                onMouseXChanged: {
                    if (!_pressed) main.height = Context.mouseY() - (main.y - 3)
                }
            }
        }

        Rectangle {
            id: resizeTop
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            height: 6
            z: 999
            color: "transparent"

            MouseArea {
                anchors.fill: parent

                property int startY: 0
                property int startH: 0
                property bool _pressed: true

                hoverEnabled: true

                onEntered: {
                    cursorShape = Qt.SizeVerCursor
                }

                onExited: {
                    cursorShape = Qt.ArrowCursor
                }

                onPressedChanged: {
                    _pressed = !_pressed
                    startY = main.y
                    startH = main.height
                }

                onMouseXChanged: {
                    if (!_pressed) {

                        main.y = Context.mouseY() - 3

                        if (startY >= Context.mouseY()) {
                            main.height = startH + (startY - Context.mouseY())
                        } else {
                            main.height = startH - (Context.mouseY() - startY)
                        }
                    }
                }
            }
        }
}
