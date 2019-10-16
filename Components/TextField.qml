//contents of TextField.qml
import QtQuick 2.0


Rectangle {
    id: textFild
    x: 0
    y: 0
    width: 100
    height: 30
    color: "transparent"
    //border {color: "#ffffff"; width: 1}

    property alias text: input.text
    property string texttmp: ""
    property alias size: input.font.pixelSize
    property int maxLength: 0
    property bool autoSize: false
    property bool clearClickPrimary: true
    property alias textColor: input.color
    property alias input: input
    property alias bg: bg
    property alias detailColor: textBarBG.color

    signal clicked(var mouse)

    Rectangle {
        id: bg
        anchors.fill: parent
        color: "#ffffff"
        opacity: 0.10
    }

    MouseArea {
        id: textMouse
        anchors.fill: parent
        onClicked: {
            animationW.to = textBar.width
            animationX.to = 0
            animationW.start()
            animationX.start()
            input.forceActiveFocus()
            textFild.clicked(textMouse)
        }
    }

    TextInput {
        id: input
        text: "Click Me!"
        anchors.centerIn: parent
        font.pixelSize: 26
        font.family: "roboto light"
        color: "#ffffff"
        selectByMouse: true
        selectionColor: detailColor
        selectedTextColor: "#ffffff"
        wrapMode: TextInput.WordWrap
        smooth: false
        //layer.enabled: true

        property bool focused: false

        onFocusChanged: {

            if (!focused) {

                animationW.to = textBar.width
                animationX.to = 0
                animationW.stop()
                animationX.stop()
                animationW.start()
                animationX.start()
                input.forceActiveFocus()
                textFild.clicked(textMouse)

                if (clearClickPrimary) {
                    input.text = ""
                    clearClickPrimary = false
                }

            } else {

                animationW.to = 0
                animationX.to = textBar.width / 2
                animationW.stop()
                animationX.stop()
                animationW.start()
                animationX.start()

                if (input.text == "") {
                    input.text = texttmp
                    clearClickPrimary = true
                }
            }

            focused = !focused
        }
    }


    Rectangle {
        id: textBarSub
        color: "#ffffff"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        width: parent.width
        height: 2
        opacity: 0.10
    }

    Rectangle {
        id: textBar
        color: "transparent"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        width: parent.width
        height: 2

        Rectangle {
            id: textBarBG
            x: parent.width / 2
            y: 0
            width: 0
            height: 2
            color: "#7310A2"

            PropertyAnimation { id: animationW; target: textBarBG; property: "width"; to: textBar.width; duration: main.efeito1 }
            PropertyAnimation { id: animationX; target: textBarBG; property: "x"; to: 0; duration: main.efeito1 }
        }
    }

    Component.onCompleted: {

        if (autoSize) {

            input.maximumLength = input.text.length
            width = input.width + size
            height = input.height + size

        } else {

            input.maximumLength = maxLength
        }

        if (clearClickPrimary) texttmp = text
    }
}
