import QtQuick
import qs.bar.components.base
import qs.data

BarButton {
    text: NightLightController.enabled ? "" : ""

    onLeftClicked: NightLightController.toggle()
}