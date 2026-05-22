import QtQuick
import QtQuick.Layouts
import qs.data
import qs.popups

RowLayout {
    spacing: 5

    Text {
        text: MprisController.isPlaying ? "" : ""
        color: "white"
        visible: MprisController.playerExists
    }

    Text {
        Layout.maximumWidth: 300
        text: MprisController.info
        color: "white"
        visible: MprisController.playerExists
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
        onTapped: {if (MprisController.activePlayer) popup.toggle()}
        margin: 5
    }
}
