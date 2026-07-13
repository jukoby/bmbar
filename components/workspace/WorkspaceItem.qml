import QtQuick
import Quickshell.Hyprland
import qs.theme

Text {
    id: workspace
    required property HyprlandWorkspace modelData

    text: getIcon()
    color: Theme.primary
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: workspace.modelData.activate()
    }

    function getIcon() {
        const isNamed = isNaN(modelData.name)
        if (modelData.active) {
            if (isNamed) return "󰓏"
            else return ""
        } else {
            if (isNamed) return "󰦤"
            else return ""
        }
    }
}