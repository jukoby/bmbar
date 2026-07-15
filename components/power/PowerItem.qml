import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.base

ThemedText {
    id: root
    font.pointSize: 18
    Layout.alignment: Qt.AlignHCenter

    required property list<string> command

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: Quickshell.execDetached(root.command)
    }
}
