//contents of List.qml
import QtQuick 2.0

Column {

    id: colun
    //property int repeat: 1
    property int selected: 0
    property var titles: []
    property int w: 200
    property int h: 50
    property int textSize: 14
    property bool multSelected: false
    property int selectedIndex: 0
    property var selectedIndexes: []

    signal selectedChange

    Repeater {
        //model: repeat
        model: titles.length

        Rectangle {
            id: repeatBase
            width: w
            height: h
            property bool _selected: index == selected ? true : false
            color: "transparent"

            Rectangle {
                id: focusColor
                anchors.fill: parent
                color: "#fff"
                opacity: 0.10
            }

            Rectangle {
                id: bg
                x: index == selected ? 0 : parent.width / 2
                y: 0
                width: index == selected ? parent.width : 0
                height: parent.height
                color: "#7310A2"

                property alias animationW: animationW
                property alias animationX: animationX

                PropertyAnimation { id: animationW; target: bg; property: "width"; to: parent.width; duration: main.efeito1 }
                PropertyAnimation { id: animationX; target: bg; property: "x"; to: 0; duration: main.efeito1 }
            }

            function effect_active()
            {
                animationW.to = repeatBase.width
                animationX.to = 0
                animationX.start()
                animationW.start()
            }

            function effect_desactive()
            {
                animationW.to = 0
                animationX.to = repeatBase.width / 2
                animationX.start()
                animationW.start()
            }

            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                width: parent.width
                height: 1
                color: "#fff"
                opacity: 0.30
            }

            Text {
                text: titles[index]
                color: "#fff"
                font.family: "roboto light"
                font.pixelSize: textSize
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onHoveredChanged: {
                    focusColor.opacity = 0.20
                    //bg.opacity = 0.85
                }

                onExited: {
                    focusColor.opacity = 0.10
                    //bg.opacity = 1
                }

                onClicked: {

                    if (!multSelected) {

                        if (!_selected) {
                            for (var i = 0; i < colun.children.length - 1; i++) {
                                var _parent = colun.children[i]

                                if (_parent._selected) {
                                    var item = _parent.children[1]
                                    item.animationW.to = 0
                                    item.animationX.to = repeatBase.width / 2
                                    item.animationW.start()
                                    item.animationX.start()
                                    _parent._selected = false
                                }
                            }

                            effect_active()
                            _selected = true
                            selectedIndex = index
                       }

                    } else {

                        colun.selectedIndexes = []
                        _selected ? effect_desactive() : effect_active()
                        _selected = !_selected

                        for (var i = 0; i < colun.children.length - 1; i++) {
                            if (colun.children[i]._selected) colun.selectedIndexes.push(i)
                        }
                        selectedIndex = index
                    }

                    selectedChange.call()
                }
            }
        }
    }
}
