import QtQuick
import qs.base
import qs.components.date.data

BarButton {
    text: Time.time
    onLeftClicked: popup.toggle()

    DatePopup { id: popup }
}
