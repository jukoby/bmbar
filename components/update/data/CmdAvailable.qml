import QtQuick
import Quickshell.Io

Process {
    id: checkProcess
    required property var modelData
    property list<string> validCommand

    command: ["which", modelData[0]]
    running: true

    onExited: (exitCode) => { // qmllint disable signal-handler-parameters
        if (exitCode === 0) {
            validCommand = modelData
        } 
    }
}