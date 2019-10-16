//contents of Card.qml
import QtQuick 2.3
import QtGraphicalEffects 1.0

Rectangle {
    width: 280
    height: 300
    color: "transparent"

    property alias image: icone.source
    property alias bg: bg.color
    property alias opc: bg.opacity
    property string title: "My card"
    property string description: "Lorem ipsum etiam morbi ornare nullam gravida torquent molestie consequat euismod"
    property int size: 14
    property string textColor: "#fff"
    property int maxTitle: 20
    property int maxDescription: 120
    property alias img: icone
    property string effectColor: "#999"

    RectangularGlow {
        id: effect
        anchors.fill: parent
        glowRadius: 12
        spread: 0
        color: effectColor
        cached: true
        cornerRadius: 12
        PropertyAnimation { id: glow1; target: effect; property: "color"; to: "#666"; duration: main.efeito1 }
        PropertyAnimation { id: glow2; target: effect; property: "glowRadius"; to: 15; duration: main.efeito1 }
        PropertyAnimation { id: glow3; target: effect; property: "cornerRadius"; to: 15; duration: main.efeito1 }
        PropertyAnimation { id: glow4; target: effect; property: "spread"; to: 0.2; duration: main.efeito1 }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {

            anicon.stop()
            glow1.stop()
            glow2.stop()
            glow3.stop()
            glow4.stop()

            anicon.to = 0.85
            glow1.to = "#666"
            glow2.to = 15
            glow3.to = 15
            glow4.to = 0.1

            anicon.start()
            glow1.start()
            glow2.start()
            glow3.start()
            glow4.start()

        }
        onExited: {

            anicon.stop()
            glow1.stop()
            glow2.stop()
            glow3.stop()
            glow4.stop()

            anicon.to = 1
            glow1.to = effectColor
            glow2.to = 12
            glow3.to = 12
            glow4.to = 0

            anicon.start()
            glow1.start()
            glow2.start()
            glow3.start()
            glow4.start()
        }
    }

    Rectangle {
        id: bg
        anchors.fill: parent
        color: "#fff"
    }

    Image {
        id: icone
        fillMode: Image.PreserveAspectCrop
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 0
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        antialiasing: true
        opacity: 1
        PropertyAnimation { id: anicon; target: icone; property: "opacity"; to: 0.85; duration: main.efeito1 }
    }

    Rectangle {
        id: bar
        height: 2
        color: "#7310A2"
    }

    Label {
        id: titulo
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
        font.bold: true
    }

    Label {
        id: text2
        wrapMode: Text.WordWrap
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.bottomMargin: 10
    }

    Component.onCompleted: {
        icone.height = (height / 2) + (height / 8)
        bar.y = icone.height
        bar.width = width
        titulo.y = icone.height + 10
        titulo.size = size + 2
        titulo.color = textColor
        titulo.text = (title.length > maxTitle) ? title.substring(0, maxTitle) + "..." : title
        text2.y = icone.height + 40
        text2.width = width
        text2.height = width - (icone.height - 40)
        text2.color = textColor
        text2.size = size
        text2.text = (description.length > maxDescription) ? description.substring(0, maxDescription) + "..." : description
    }
}
