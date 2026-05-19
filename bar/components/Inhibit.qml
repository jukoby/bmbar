import QtQuick
import qs.bar.components.base
import qs.data

BarButton {
    text: InhibitController.enabled ? "󰒳" : "󰒲"
    onLeftClicked: InhibitController.enabled = !InhibitController.enabled
}