import QtQuick
import QtQuick.Controls
import qs.theme

Label {
    id: root
    property bool applyBackground: false

    color: Theme.primary
    font.bold: applyBackground
    background: Rectangle {
        color: root.applyBackground ? Theme.bgAlt : "transparent"
        opacity: 0.7
        radius: 7
        visible: root.applyBackground
    }
}