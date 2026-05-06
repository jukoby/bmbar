import QtQuick
import QtQuick.Layouts
import qs.popups.base
import qs.popups.components.power

PanelPopup {
    id: popup
    rightSide: false

    contentItem: Item {
        implicitHeight: layout.implicitHeight
        implicitWidth: 50
        
        ColumnLayout {
            id: layout
            anchors.fill: parent
            spacing: 5

            PowerItem {
                text: ""
                command: ["systemctl", "poweroff"]
            }

            PowerItem {
                text: ""
                command: ["systemctl", "reboot"]
            }

            PowerItem {
                text: "󰤄"
                command: ["systemctl", "sleep"]
                scale: 1.7
            }

            PowerItem {
                text: ""
                command: ["loginctl", "terminate-session"]
                bottomPadding: 10
            }
        }
    }
}