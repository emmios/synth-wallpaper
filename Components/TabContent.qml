import QtQuick 2.3


Rectangle {
    x: 0
    y: 60
    z: tabs.titles.length - index
    width: parent.width
    height: parent.height - y
    color: "transparent"
    visible: (index == 0) ? true : false
    //Label {text: "Option - " + index}
}
