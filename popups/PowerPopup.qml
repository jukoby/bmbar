pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets 
import qs.base
import qs.popups.components.power

PanelPopup {
    id: popup
    side: Side.LEFT

    contentItem: WrapperItem {
        implicitWidth: 45
        
        ColumnLayout {
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
                text: "󰗽"
                command: ["loginctl", "terminate-session"]
            }
        }
    }
}
