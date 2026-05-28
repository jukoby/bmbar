import QtQuick
import qs.base
import qs.components.inhibit.data

BarButton {
    text: InhibitData.enabled ? "󰒳" : "󰒲"
    onLeftClicked: InhibitData.enabled = !InhibitData.enabled
}