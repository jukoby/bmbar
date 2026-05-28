import QtQuick
import Quickshell
import qs.base

BarButton {
    text: "󰈊"
    onLeftClicked: Quickshell.execDetached(["hyprpicker", "-a", "-n"])
}