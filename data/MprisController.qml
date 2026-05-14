pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Services.Mpris
import QtQuick

Singleton {
    id: root
    property var players: Mpris.players;
    property MprisPlayer trackedPlayer: null
	property MprisPlayer activePlayer: trackedPlayer ?? Mpris.players.values[0] ?? null;

    Instantiator {
		model: root.players;

		Connections {
			required property MprisPlayer modelData;
			target: modelData;

			function onPlaybackStateChanged() {
				if (root.trackedPlayer !== modelData) root.trackedPlayer = modelData;
			}
		}
	}

	function getTrack() {
		return root.activePlayer?.trackTitle ? 
			`${root.activePlayer.trackTitle} - ${root.activePlayer.trackArtist}` :
			""
	}

	function isPlaying() {
		return root.activePlayer?.isPlaying
	}

	function playerExists() {
		return !(root.activePlayer === null)
	}
}
