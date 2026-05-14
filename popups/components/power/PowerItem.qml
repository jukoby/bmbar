import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell

Button {
    required property list<string> command
    Layout.alignment: Qt.AlignHCenter
    scale: 1.5
    background: null
    onClicked: Quickshell.execDetached(command)
}
