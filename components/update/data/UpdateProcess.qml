import Quickshell
import Quickshell.Io

Scope {
    id: root
    required property list<string> checkCommand 
    required property list<string> updateCommand
    property alias checkRunning: checkProcess.running
    property alias updateRunning: updateProcess.running
    property int updates: 0

    Process {
        id: checkProcess
        command: root.checkCommand
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.updates = checkProcess.getLines(text)
        }

        function getLines(text) {
            return text ? text.trim().split('\n').length : 0
        }
    }

    Process {
        id: updateProcess
        running: false
        command: root.updateCommand

        onRunningChanged: if (!running) checkProcess.running = true
    }
}
