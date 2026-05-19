pragma Singleton

import Quickshell
import Quickshell.Wayland 

Singleton {
    property alias enabled: inhibitor.enabled

    IdleInhibitor {
        id: inhibitor
        window: window
        enabled: enabled
    }
}