import QtQuick
import Quickshell.Io
import qs.bar.components.base

BarButton {
    text: process.running ? "󰒳" : "󰒲"
    onLeftClicked: process.running = !process.running

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
    /*
    text: Inhibitor.enabled ? "󰈉" : "󰈈"

    onLeftClicked: {
        Inhibitor.enabled = !Inhibitor.enabled
    }
    */
}