import QtQuick
import Quickshell
import qs.bar.components.base

BarButton {
    text: "󰈊"
    onLeftClicked: Quickshell.execDetached(["hyprpicker", "-a", "-n"])
}