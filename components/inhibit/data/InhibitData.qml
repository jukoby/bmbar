pragma Singleton

import Quickshell
import Quickshell.Io 

Singleton {
    property alias enabled: process.running

    Process {
        id: process
        running: false
        command: [
            "systemd-inhibit", 
            "--who=quickshell",
            "--why=Inhibiting idle state",
            "sleep", 
            "infinity"
        ]
    }
}
