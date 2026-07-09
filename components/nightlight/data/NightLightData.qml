pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: data
    property bool enabled: false

    function toggle() {
        const temp = enabled ? "6500": "3500" // "reset" for new release
        enabled = !enabled
        Quickshell.execDetached(["hyprctl", "hyprsunset", "temperature", temp])
    }

    Process {
        id: checkCommand
        running: true
        command: ["hyprctl", "hyprsunset", "temperature"]
        stdout: StdioCollector {
            onStreamFinished: data.enabled = parseInt(text) < 4500
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: checkCommand.running = true
    }
}
