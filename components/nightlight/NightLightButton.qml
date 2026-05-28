import QtQuick
import qs.base
import qs.components.nightlight.data

BarButton {
    text: NightLightData.enabled ? "" : ""

    onLeftClicked: NightLightData.toggle()
}