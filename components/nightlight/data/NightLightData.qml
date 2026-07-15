pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: nightLight
    property bool enabled: false

    function toggle() {
        const command = enabled ? ["reset", "temperature"]: ["temperature", "3500"]
        Quickshell.execDetached(["hyprctl", "hyprsunset", ...command])
        enabled = !enabled
    }

    Process {
        id: checkCommand
        running: true
        command: ["hyprctl", "hyprsunset", "temperature"]
        stdout: StdioCollector {
            onStreamFinished: nightLight.enabled = parseInt(text) < 6000
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: checkCommand.running = true
    }
}
