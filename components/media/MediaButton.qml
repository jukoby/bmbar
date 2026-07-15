import QtQuick
import QtQuick.Layouts
import qs.base
import qs.components.media.data

RowLayout {
    spacing: 5

    ThemedText {
        text: MediaData.isPlaying ? "" : ""
        visible: MediaData.playerExists
    }

    ThemedText {
        Layout.maximumWidth: 300
        text: MediaData.info
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
