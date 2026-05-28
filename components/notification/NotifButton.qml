import QtQuick
import Quickshell
import qs.base
import qs.components.notification.data

BarButton {
    text: getNotificationIcon()
    function getNotificationIcon() {
        if (NotifData.dnd) {
            return "󰂛"
        }
        if (NotifData.trackedAmount > 0) {
            return "󱅫"
        }
        return "󰂚"
    }

    onLeftClicked: popup.toggle()
    NotifPopup { id: popup }

    QsWindow.onWindowChanged: {
        if (QsWindow.window?.screen) { // qmllint disable missing-property
            NotifData.register(QsWindow.window.screen.name, popup) // qmllint disable missing-property
        }
    }
}
