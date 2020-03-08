import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import "./Components"


AppCustom {
    id: bg
    title: "Wallpaper"
    x: (Screen.desktopAvailableWidth / 2) - (width / 2)
    y: (Screen.desktopAvailableHeight / 2) - (height / 2)
    width: 920
    height: 600
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowSystemMenuHint
    color: "transparent"

    property string bgColor: "#161616"
    property string path: Context.backgroundPath()//"/usr/share/backgrounds/"

    onClosing: {
        Context.positions(x, y, width, height)
    }

    MouseArea {
        id: mouseBg
        anchors.fill: parent
        anchors.margins: 2
        enabled: false

        property int initialX: 0

        onPressed: {
            initialX = mouseX
            cursorShape = Qt.SizeAllCursor
        }

        onReleased: {
            cursorShape = Qt.ArrowCursor
        }

        onMouseXChanged: {
            bg.x = Context.mouseX() - initialX
            Context.windowMove(bg.x, bg.y, bg.width, bg.height)
        }

        onMouseYChanged: {
            if (mouseY > 0) {
                bg.y = Context.mouseY() - 15
            } else {
                bg.y = Context.mouseY() - 2
            }
            Context.windowMove(bg.x, bg.y, bg.width, bg.height)
        }

        /*
        property var clickPos: "1, 1"
        property int bgX: bg.x
        property int bgY: bg.y

        onPressed: {
            cursorShape = Qt.SizeAllCursor
            clickPos = Qt.point(mouse.x, mouse.y)
        }

        onPositionChanged: {
            var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
            //bg.x += delta.x
            //bg.y += delta.y
            bgX += delta.x
            bgY += delta.y
            Context.windowMove(bgX, bgY, bg.width, bg.height)
        }*/
    }

    Rectangle {
        anchors.fill: parent
        color: bgColor
        opacity: 0.94
    }

    Image {
        anchors.fill: parent
        source: "qrc:/Resources/noise.png"
        opacity: 0.1
    }

    Rectangle {
        id: graidArea
        anchors.fill: parent
        color: "transparent"

        Rectangle {
            id: subArea
            x: 10
            y: 35
            width: parent.width - 20
            height: parent.height - 45
            color: "transparent"

            ListModel {
                id: listModel
                function createListElement(arg) {
                    return {img: arg}
                }

                function reload() {
                    clear()
                    var imgs = Context.backgrouds(path)
                    for (var i = 0; i < imgs.length; i++) {
                        append(createListElement(imgs[i]))
                    }
                }
            }

            GridView {
                id: gridView
                //highlight: highlight
                highlightFollowsCurrentItem: true
                focus: true
                keyNavigationWraps: true
                layoutDirection: GridView.LeftToRight//Qt.LeftToRight
                flow: GridView.FlowLeftToRight
                //flow: GridView.FlowTopToBottom
                verticalLayoutDirection: GridView.TopToBottom
                //flickableDirection: Flickable.HorizontalFlick
                flickableDirection: Flickable.VerticalFlick
                //flickableDirection: Flickable.HorizontalAndVerticalFlick
                interactive: true
                anchors.fill: parent
                clip: true
                //antialiasing: false
                model: []

                delegate: Item {
                    Column {
                        width: gridView.cellWidth
                        height: gridView.cellHeight

                        Image {
                            width: parent.width - 10
                            height: parent.height - 10
                            source: "image://pixmap/" + img
                            anchors.horizontalCenter: parent.horizontalCenter
                            antialiasing: false
                            fillMode: Image.PreserveAspectCrop
                            asynchronous: true
                            smooth: false
                            cache: true
                            property string url: img

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    Context.backgroundChange(img)
                                }
                            }
                        }

                        spacing: 10
                    }
                }

                cellWidth: 150
                cellHeight: 100
            }
        }
    }

    Rectangle {
        id: load
        anchors.fill: parent
        color: "#fff"
        visible: true
        AnimatedImage {
            id: loading
            x: (bg.width / 2) - (250 / 2)
            y: (bg.height / 2) - (250 / 2)
            width: 250
            height: 250
            source: "qrc:/icons/loading.gif"
            asynchronous: true
            cache: false
        }
    }

    Label {
        y: 6
        x: 14
        text: '\uf07c'
        size: 18
        color: "#999"
        font.family: "Font Awesome 5 Free"
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: {
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                fileDialog.setFolder("file://" + path)
                fileDialog.open()
                //Context.windowMove()
            }
        }
    }


    Label {
        y: 5
        x: bg.width - 22
        text: '\uf00d'
        size: 18
        color: "#999"
        font.family: "Font Awesome 5 Free"
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: {
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                bg.close()
            }
        }
    }

    FileDialog {
        id: fileDialog
        width: 800
        height: 480
        title: "Selecione uma pasta"
        folder: "file://" + path
        selectFolder: true
        modality: Qt.NonModal
        onAccepted: {
            path = fileDialog.folder.toString().replace('file://', '')
            Context.backgroundPath(path)
            listModel.reload()
            gridView.model = listModel

            if (width > 400 || height > 400) {
                time.start()
            }
        }
        onRejected: {
            //console.log("Canceled")
        }
        Component.onCompleted: {
            width = 800
            height = 480
        }
    }


    Timer {
        id: time
        running: false
        interval: 3000
        onTriggered: {
            load.visible = false
            mouseBg.enabled = true
        }
    }

    Timer {
        id: orientation
        running: false
        interval: 2000
        onTriggered: {
            if (width - height >= height) {
                gridView.flow = GridView.FlowTopToBottom
                gridView.flickableDirection = Flickable.HorizontalFlick
            } else {
                gridView.layoutDirection = GridView.FlowLeftToRight
                gridView.flickableDirection = Flickable.VerticalFlick
            }
        }
    }

    onWidthChanged: {
        orientation.stop()
        orientation.start()
    }

    onHeightChanged: {
        orientation.stop()
        orientation.start()
    }

    Component.onCompleted: {
        var pos = Context.positions()
        x = pos[0]
        y = pos[1]
        width = pos[2]
        height = pos[3]

        if (width <= 400 || height <= 400) {
            load.visible = false
        } else {
            time.start()
        }

        if (width - height >= height) {
            gridView.flow = GridView.FlowTopToBottom
            gridView.flickableDirection = Flickable.HorizontalFlick
        } else {
            gridView.layoutDirection = GridView.FlowLeftToRight
            gridView.flickableDirection = Flickable.VerticalFlick
        }

        listModel.reload()
        gridView.model = listModel
    }
}
