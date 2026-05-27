import QtQuick
import qs.base
import qs.data

BarButton {
    text: NightLightController.enabled ? "" : ""

    onLeftClicked: NightLightController.toggle()
}