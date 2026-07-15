pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Controls
import qs.base
import qs.components.notification.data

PanelPopup {
    id: popup
    side: Side.RIGHT

    property int newNotifCount: 0
    property bool showNewNotifs: false

    mask: showNewNotifs ? maskRegion: null

    Region {
        id: maskRegion
        width: popup.contentItem.width
        height: popup.contentItem.height + 10
        x: Screen.width - popup.contentItem.width + 20
    }

    contentItem: Item {
        id: outerItem
        height: popup.showNewNotifs ? 
            popup.newNotifCount * (notificationHeight + notificationSpacing) :
            childrenRect.height
        width: 350
        clip: true

        Behavior on height {
            enabled: popup.showNewNotifs
            NumberAnimation {
                duration: 150
            }
        }

        property int notificationHeight: 85
        property int notificationSpacing: 10

        Column {
            id: controls
            height: popup.showNewNotifs ? 0 : 60
            width: parent.width
            visible: !popup.showNewNotifs

            Switch {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Do not Disturb"
                checked: NotifData.dnd
                onClicked: NotifData.dnd = checked
                // TODO: Color
            }

            ThemedText {
                anchors.horizontalCenter: parent.horizontalCenter
                text: NotifData.trackedAmount === 0 
                    ? " No Notifications" 
                    : " Clear Notifications"

                TapHandler {
                    acceptedButtons: Qt.LeftButton
                    onTapped: {
                        for (let i = 0; i < repeater.count; i++) {
                            repeater.itemAt(i).dismiss() // qmllint disable missing-property
                        }
                    }
                }
            }
        }

        Repeater {
            id: repeater
            model: NotifData.model
            delegate: NotifRect {
                required property int index
                width: outerItem.width - 20
                height: outerItem.notificationHeight
                y: (repeater.count - index - 1) 
                    * (height + outerItem.notificationSpacing)
                    + controls.height + 5
                Behavior on y {
                    NumberAnimation {
                        duration: 150
                    }
                }
            }

            onItemAdded: {
                if (popup.showNewNotifs) {        
                    popup.newNotifCount += 1
                    newNotifsTimer.restart()
                }
            }

            onItemRemoved: {
                if (popup.showNewNotifs) {
                    popup.newNotifCount -= 1
                    newNotifsTimer.restart()
                }
            }
        }
    }

    function showPopup() {
        if (!NotifData.dnd && !popup.active) {
            showNewNotifs = true
            newNotifsTimer.start()
        }
    }
    
    Timer {
        id: newNotifsTimer
        interval: 5000

        // on start
        onRunningChanged: {
            if (running && !popup.active) {
                popup.toggle()
            }
        }

        // on end
        onTriggered: {
            if (popup.active && popup.showNewNotifs) {
                popup.toggle()
            }
        }
    }

    onActiveChanged: {
        if (!active && showNewNotifs) {
            newNotifCount = 0
            showNewNotifs = false
        }
    }
}
