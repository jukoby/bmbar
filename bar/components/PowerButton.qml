import QtQuick
import qs.base
import qs.popups

BarButton {
    text: ""
    onLeftClicked: popup.toggle()

    PowerPopup { id: popup }
}
