pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.popups.base
import qs.popups.components.media
import qs.data

PanelPopup {
    id: popup
    side: Side.CENTER

    property int imageSize: 100

    contentItem: ColumnLayout {
        width: 450

        MediaEntry { 
            player: MprisController.activePlayer
        }
    }
}