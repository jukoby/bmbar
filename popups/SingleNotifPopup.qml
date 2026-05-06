import QtQuick
import Quickshell.Services.Notifications
import qs.popups.base
import qs.popups.components.notification

PanelPopup {
    id: popup
    rightSide: true
    required property Notification modelData

    contentItem: NotificationRect {  
        width: 350
        modelData: popup.modelData
    }
}