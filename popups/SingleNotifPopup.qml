import QtQuick
import Quickshell.Services.Notifications
import qs.popups.base
import qs.popups.components.notification

HorizontalPopup {
    id: popup
    rightSide: true
    required property Notification modelData

    contentItem: NotificationRect {  
        width: 350
        modelData: popup.modelData
    }
}