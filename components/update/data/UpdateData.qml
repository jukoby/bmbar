pragma ComponentBehavior: Bound
pragma Singleton
import QtQuick
import Quickshell

Singleton {
    id: updater
    property alias linuxUpdates: linux.updates
    property alias flatpakUpdates: flatpak.updates
    property bool updating: linux.checkRunning || flatpak.checkRunning
    property list<string> linuxUpdateCommand: ["pacman", "-Syu"]
    property list<string> terminalCommand

    UpdateProcess {
        id: linux
        checkCommand: ["checkupdates"]
        updateCommand: [...updater.terminalCommand, ...updater.linuxUpdateCommand]
    }

    UpdateProcess {
        id: flatpak
        checkCommand: ["flatpak", "remote-ls", "--updates"]
        updateCommand: [...updater.terminalCommand, "flatpak", "update"]
    }

    Timer {
        interval: 900000 // 15 min
        running: true
        repeat: true
        onTriggered: updater.checkUpdate()
    }

    function checkUpdate() {
        linux.checkRunning = true
        flatpak.checkRunning = true
    }

    function runUpdate() {
        if (UpdateData.linuxUpdates > 0) linux.updateRunning = true
        if (UpdateData.flatpakUpdates > 0) flatpak.updateRunning = true
    }

    // Check which terminal is available
    Variants {
        model: [
            ["alacritty", "-e"],
            ["konsole", "-e"],
            ["xterm", "-e"],
            ["ghostty", "-e"],
            ["gnome-terminal", "--"],
            ["kitty", "--"],
            ["foot"],
        ]

        CmdAvailable {
            onValidCommandChanged: {
                updater.terminalCommand = validCommand
            }
        }
    }

    // Check which linux package updater is available
    Variants {
        model: [
            ["yay"],
            ["paru"],
            ["pikaur", "-Syu"],
            ["trizen", "-Syu"],
        ]

        CmdAvailable {
            onValidCommandChanged: {
                updater.linuxUpdateCommand = validCommand
            }
        }
    }
}
