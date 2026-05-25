import QtQuick
import Quickshell
import qs.data
import qs.bar.components.base
import qs.popups

BarButton {
    text: getNotificationIcon()
    function getNotificationIcon() {
        if (NotifController.dnd) {
            return "󰂛"
        }
        if (NotifController.trackedAmount > 0) {
            return "󱅫"
        }
        return "󰂚"
    }

    onLeftClicked: popup.toggle()
    NotificationPopup { id: popup }

    QsWindow.onWindowChanged: {
        if (QsWindow.window?.screen) { // qmllint disable missing-property
            NotifController.register(QsWindow.window.screen.name, popup) // qmllint disable missing-property
        }
    }
}
