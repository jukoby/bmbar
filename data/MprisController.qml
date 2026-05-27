pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick

Singleton {
    id: root

    property MprisPlayer activePlayer: null
	property var otherPlayers: Mpris.players.values.filter(
		p => p.trackTitle != "" && p.trackTitle != activePlayer.trackTitle
	)

	signal playerChanged(string title)

	onPlayerChanged: (title) => {
		const trimmedTitle = title.trim()
		if (trimmedTitle && trimmedTitle !== activePlayer?.trackTitle) {
			root.activePlayer = Mpris.players.values.find(
				p => p.trackTitle.trim() === title.trim()
			)
		}
    }

	Process {
        id: getPlayer
        running: false
        command: ["playerctl", "metadata", "xesam:title"]
        stdout: StdioCollector {
            onStreamFinished: root.playerChanged(text)
        }
    }

	Timer {
		running: true
		repeat: true
		interval: 500

		onTriggered: getPlayer.running = true
	}

	readonly property string info: activePlayer?.trackTitle ?
		`${activePlayer?.trackTitle} - ${activePlayer?.trackArtist}` :
		""

	readonly property bool isPlaying: activePlayer?.isPlaying
	readonly property bool playerExists: !(activePlayer === null)
}
