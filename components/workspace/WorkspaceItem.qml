import QtQuick
import Quickshell.Hyprland
import qs.theme

Text {
    id: workspace
    required property HyprlandWorkspace modelData

    text: modelData.active ? "" : ""
    color: Theme.primary
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: workspace.modelData.activate()
    }
}