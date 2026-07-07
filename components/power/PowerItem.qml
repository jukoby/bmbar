import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.theme

Text {
    id: root
    scale: 1.5
    color: Theme.primary
    horizontalAlignment: Qt.AlignHCenter
    Layout.alignment: Qt.AlignHCenter

    required property list<string> command

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: Quickshell.execDetached(root.command)
    }
}
