pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Singleton {
    id: root

    property bool enabled: idleInhibitor.enabled

    /* TODO Wait for update
    IdleInhibitor { 
        id: idleInhibitor
        enabled: false
        window: PanelWindow {
            implicitWidth: 0
            implicitHeight: 0
            color: "transparent"
            mask: Region {}
        }
    }
    */
}