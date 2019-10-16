import QtQuick 2.3
import "../Components"


Item {
    id: tabs
    x: 0
    y: 0
    anchors.fill: parent

    property alias titles: rowTabs.titles
    property int _index: 0
    property string textColor: "#fff"
    property double optionSize: 180

    signal click

    Row {
        id: rowTabs
        x: 0
        y: 0
        anchors.fill: parent

        property var titles: []

        Repeater {
            id: tabs_content
            model: titles

            Rectangle {
                width: 180
                height: 40
                color: "transparent"

                property alias cor_select: cor_select

                Rectangle {
                    height: 40
                    anchors.leftMargin: 0
                    anchors.left: parent.left
                    anchors.rightMargin: 10
                    anchors.right: parent.right
                    color: "transparent"

                    property alias cor_select: cor_select

                    Label {
                        id: label
                        text: modelData
                        y: 8
                        size: 12
                        Component.onCompleted: {
                            x = (parent.width / 2) - (width / 2)
                            color = textColor
                        }
                    }

                    Rectangle {
                        id: cor_select
                        height: 2
                        anchors.leftMargin: 0
                        anchors.left: parent.left
                        anchors.rightMargin: 0
                        anchors.right: parent.right
                        anchors.bottomMargin: 0
                        anchors.bottom: parent.bottom
                        Component.onCompleted: {
                            color = (index == 0) ? "#7310A2" : "transparent"
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        for (var i = 0; i < titles.length; i++) {
                            tabs_content.itemAt(i).cor_select.color = "transparent"
                        }
                        cor_select.color = "#7310A2"
                        _index = index
                        click()
                    }
                }

                Component.onCompleted: {
                        width = optionSize
                }
            }
        }
    }
}

