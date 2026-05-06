import QtQuick
import QtQuick.Layouts
import qs.data

RowLayout {
    Text {
        text: MprisController.isPlaying() ? "" : ""
        color: "white"
        visible: MprisController.playerExists()
    }

    Text {
        Layout.maximumWidth: 300
        text: MprisController.getTrack()
        color: "white"
        visible: MprisController.playerExists()
        elide: Text.ElideRight
    }
}
