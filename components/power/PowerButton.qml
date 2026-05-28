import QtQuick
import qs.base

BarButton {
    text: ""
    onLeftClicked: popup.toggle()

    PowerPopup { id: popup }
}
