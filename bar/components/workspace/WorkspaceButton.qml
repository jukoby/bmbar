import QtQuick
import Quickshell.Hyprland

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