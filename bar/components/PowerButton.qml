import QtQuick
import qs.bar.components.base
import qs.popups

BarButton {
    text: ""
    onLeftClicked: popup.toggle()

    PowerPopup { id: popup }
}
