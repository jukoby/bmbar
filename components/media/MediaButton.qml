import QtQuick
import QtQuick.Layouts
import qs.components.media.data

RowLayout {
    spacing: 5

    Text {
        text: MediaData.isPlaying ? "" : ""
        color: "white"
        visible: MediaData.playerExists
    }

    Text {
        Layout.maximumWidth: 300
        text: MediaData.info
        color: "white"
        visible: MediaData.playerExists
        elide: Text.ElideRight
        // TODO: fade Behavior
    }

    // wrap in item to fix text wobbling on toggle
    // (idk why do i have to do this)
    Item {
        MediaPopup { id: popup }
    }

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: {if (MediaData.activePlayer) popup.toggle()}
        margin: 5
    }
}
