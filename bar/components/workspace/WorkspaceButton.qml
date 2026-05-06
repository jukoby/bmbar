import QtQuick
import QtQuick.Controls
import Quickshell.Hyprland
import Quickshell


Text {
    id: workspace
    required property HyprlandWorkspace modelData

    text: modelData.active ? "" : ""
    color: "white"
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: workspace.modelData.activate()
    }
}