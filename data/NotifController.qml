pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Notifications

Singleton {
    id: notifController

    property bool dnd: false
    property int trackedAmount: model.values.length
    property var popupRegistry: ({})

    NotificationServer {
        id: server
        bodySupported: true
        bodyHyperlinksSupported: true
        bodyMarkupSupported: true

        imageSupported: true
        bodyImagesSupported: true

        actionsSupported: true
        actionIconsSupported: true

        keepOnReload: false
        persistenceSupported: false

        onNotification: notification => {
            notification.tracked = true;
            notifController.popupRegistry[Hyprland.focusedMonitor.name].showPopup()
        }
    }

    function register(key, val) {
        popupRegistry[key] = val;
    }

    property alias model: server.trackedNotifications

    function dismissAll() {
        while (NotifController.trackedAmount !== 0) {
            model.values[0].tracked = false
        }
    }
}
