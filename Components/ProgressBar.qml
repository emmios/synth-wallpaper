import QtQuick 2.3


Rectangle {
    id: progress
    x: 0
    y: 0
    width: 200
    height: 10
    radius: height
    color: "transparent"

    property int max: 0
    property int min: 0
    property int atual: 0

    property int pro: 0
    property int value: 0
    property int mousex
    property int mousey

    signal click
    signal move
    signal hover
    signal out

    Rectangle {
        x: 0
        y: 0
        width: progress.width
        height: progress.height
        color: "#ffffff"
        opacity: 0.5
        radius: height
    }

    Rectangle {
        id: indicate
        x: 0
        y: 0
        width: 0
        height: progress.height
        color: "#7310A2"
        radius: height
    }

    function getPercentage() {
        if (arguments.length === 1) {
            return (arguments[0] * 100) / progress.width
        } else {
            return (arguments[0] * 100) / arguments[1]
        }
    }

    function setPorcentage() {
        if (arguments.length === 1) {
            return (arguments[0] * progress.width) / 100
        } else {
            return (arguments[0] * arguments[1]) / 100
        }
    }

    MouseArea {

        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            indicate.width = mouseX
            pro = getPercentage(mouseX)
            atual = setPorcentage(pro, max)
            click.call()
        }

        onMouseXChanged: {
            mousex = mouseX
            mousey = mouseY
            value = setPorcentage(getPercentage(mouseX), max)
            move.call()
        }

        onHoveredChanged: {
            mousex = mouseX
            mousey = mouseY
            value = setPorcentage(getPercentage(mouseX), max)
            hover.call()
        }
        onExited: {
            out.call()
        }
    }

    onAtualChanged: {
        pro = setPorcentage(getPercentage(atual, max))
        indicate.width = pro
    }

    onWidthChanged: {
        indicate.width = setPorcentage(pro)
    }
}
