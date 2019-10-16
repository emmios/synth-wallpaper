//contents of Control.qml
import QtQuick 2.3


Rectangle {
    id: control
    width: 100
    height: 4
    radius: height
    color: "transparent"

    property alias bg: bg
    property string detail: "#7310A2"

    Rectangle {
        id: bg
        anchors.fill: parent
        color: "#fff"
        radius: height
    }

    property int value: 0
    property int perValue: 0
    property int percentage: -1
    property int position: -1

    signal change

    function setPosition() {
        perValue = parseInt((position * 100) / width)
        value = position
        controlBtn.x = position - (controlBtn.width / 2)
    }

    function setPercentage() {
        perValue = percentage
        value = parseInt((percentage * width) / 100)
        controlBtn.x = value - (controlBtn.width / 2)
    }

    function update() {
        if (position != -1) {
            setPosition()
        }

        if (percentage != -1) {
            setPercentage()
        }
    }

    onPositionChanged: {
        update()
    }

    onPercentageChanged: {
        update()
    }

    MouseArea {
        id: mouseControl
        anchors.fill: parent
        property bool move: false

        Rectangle {
            id: controlBtn
            x: 0
            y: -(parent.height / 2) - 2
            width: parent.height * 2 + 4
            height: parent.height * 2 + 4
            radius: parent.height + 2
            color: detail
            z: 1
        }

        Rectangle {
            id: controlBar
            width: controlBtn.x + (controlBtn.width / 2)
            height: parent.height
            radius: parent.height
            color: detail
        }

        onPressedChanged: {
            move = !move
        }

        onMouseXChanged: {
            if (move && 0 <= mouseX && parent.width >= mouseX) {

                control.perValue = parseInt((mouseX * 100) / control.width)
                control.value = mouseX
                percentage = control.perValue
                position = mouseX
                control.change()
            }
        }

        onClicked: {
            control.perValue = parseInt((mouseX * 100) / control.width)
            control.value = mouseX
            percentage = control.perValue
            position = mouseX
            control.change()
        }

        onWheel: {

            var scroll = wheel.angleDelta.y / 100
            var per = parseInt((2 * control.width) / 100)

            if (scroll > 0) {
                if (controlBtn.x < control.width - (controlBtn.width / 2)) {
                    percentage += per
                    control.perValue = parseInt((control.value * 100) / control.width)
                }
            } else {
                if (controlBtn.x > -(controlBtn.width / 2)) {
                    percentage -= per
                    control.perValue = parseInt((control.value * 100) / control.width)
                }
            }

            change()
        }
    }

    Component.onCompleted: {
        update()
        change()
    }
}
