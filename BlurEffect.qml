import QtQuick 2.9
import QtGraphicalEffects 1.0

Item {
    anchors.fill: parent
    property string source: ""
    property alias radius: fastBlur.radius
    property alias saturation: saturation.saturation

    onSourceChanged: {
        if (source !== "") imgBlur.source = source
    }

    Image {
        id: imgBlur
        anchors.fill: parent
        visible: false
        cache: true
        onSourceChanged: {
            imgBlur.visible = true
        }
    }

    FastBlur {
        id: fastBlur
        anchors.fill: imgBlur
        source: imgBlur
        radius: 60
        visible: imgBlur.visible
    }

    HueSaturation {
        id: saturation
        anchors.fill: fastBlur
        source: fastBlur
        hue: 0
        saturation: 0.8
        lightness: 0
        visible: imgBlur.visible
    }
}
