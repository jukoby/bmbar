import QtQuick
import Quickshell
import Quickshell.Wayland 
import qs.bar.components.base

BarButton {
    text: inhibitor.enabled ? "󰒳" : "󰒲"
    onLeftClicked: inhibitor.enabled = !inhibitor.enabled

    IdleInhibitor {
        id: inhibitor
        window: QsWindow.window
        enabled: false
    }
}