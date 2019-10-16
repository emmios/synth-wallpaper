//contents of Button.qml
import QtQuick 2.3


Rectangle {
    id: button
    color: "transparent"

    property alias text: label.text
    property alias size: label.font.pixelSize
    property alias textColor: label.color
    property string detailColor: "#7310A2"
    property alias bg: bg

    signal click

    Rectangle {
        id: buttonBg
        x: parent.width / 2
        y: parent.height / 2
        width: 0
        height: 0
        color: detailColor
        opacity: 0.0

        PropertyAnimation { id: animationOpc; target: buttonBg; property: "opacity"; to: 0.75; duration: main.efeito1 - 100 }
        PropertyAnimation { id: animationW; target: buttonBg; property: "width"; to: button.width; duration: main.efeito1 }
        PropertyAnimation { id: animationX; target: buttonBg; property: "x"; to: 0; duration: main.efeito1 }
        PropertyAnimation { id: animationH; target: buttonBg; property: "height"; to: button.height; duration: 50 }
        PropertyAnimation { id: animationY; target: buttonBg; property: "y"; to: 0; easing.type: Easing.InQuad; duration: 50 }
    }

    function aniStart() {

        //buttomBar.visible = false

        animationOpc.to = 0.75
        animationOpc.duration = main.efeito1 - 100
        animationOpc.start()

        animationW.to = button.width
        animationW.duration = main.efeito1
        animationW.start()

        animationX.to = 0
        animationX.duration = main.efeito1
        animationX.start()

        animationH.to = button.height
        animationH.duration = 50
        animationH.start()

        animationY.to = 0
        animationY.duration = 50
        animationY.start()
    }

    function fadeIn() {
        //showBar.start()
        animationOpc.to = 0.0
        animationOpc.duration = main.efeito2
        animationOpc.start()
    }

    function aniReset() {

        animationOpc.to = 0.0
        animationOpc.duration = 0
        animationOpc.start()

        animationW.to = 0
        animationW.duration = 0
        animationW.start()

        animationX.to = button.width / 2
        animationX.duration = 0
        animationX.start()

        animationH.to = 0
        animationH.duration = 0
        animationH.start()

        animationY.to = button.height / 2
        animationY.duration = 0
        animationY.start()
    }

    Rectangle {
        id: bg
        color: "#ffffff"
        anchors.fill: parent
        opacity: 0
    }

    Text {
        id: label
        text: "Click Me!"
        anchors.centerIn: parent
        font.pixelSize: 26
        font.family: "roboto light"
        color: "#fff"
    }

    Rectangle {
        id: buttomBar
        color: "#ffffff"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        width: parent.width
        height: 2
        opacity: 0.25
    }

    MouseArea {
        id: startEffects
        anchors.fill: parent
        hoverEnabled: true

        property bool isHover: true
        property bool effectEnd: true

        onHoveredChanged: {

            if (isHover) {
                buttomBar.color = detailColor
                buttomBar.opacity = 1
            } else {
                buttomBar.color = "#ffffff"
                buttomBar.opacity = 0.25
            }

            isHover = !isHover
        }

        onClicked: {
            if (effectEnd) {
                aniReset()
                aniStart()
                effect.start()
                click()
                effectEnd = false
            }
        }
    }

    Timer {
        id: effect
        interval: main.efeito1
        repeat: false
        onTriggered: {
            fadeIn()
            activeEffect.start()
        }
    }

    Timer {
        id: activeEffect
        interval: main.efeito2
        repeat: false
        onTriggered: {
            startEffects.effectEnd = true
        }
    }

    Component.onCompleted: {
        width = label.width + (16 * 2)
        height = label.height + (12 * 2)
    }
}
