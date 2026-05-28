import QtQuick
import QtQuick.Layouts
import Quickshell

Text {
    id: root
    scale: 1.5
    color: "white"
    horizontalAlignment: Qt.AlignHCenter
    Layout.alignment: Qt.AlignHCenter

    required property list<string> command

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: Quickshell.execDetached(root.command)
    }
}
