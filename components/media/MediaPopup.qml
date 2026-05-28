pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import qs.base
import qs.components.media.data

PanelPopup {
    id: popup
    side: Side.CENTER

    property int imageSize: 100
    property bool expanded: false

    contentItem: ColumnLayout {
        width: 450
        spacing: 0

        MediaEntry {
            player: MediaData.activePlayer
        }

        Repeater {
            model: MediaData.otherPlayers

            ColumnLayout {
                id: container
                spacing: popup.expanded ? 15 : 0
                Layout.topMargin: spacing

                // fix height not changing when activePlayer changes
                Layout.preferredHeight: popup.expanded ? childrenRect.height : 0

                required property MprisPlayer modelData

                HorizontalLine {
                    visible: popup.expanded
                }
                
                MediaEntry {
                    player: container.modelData
                    visible: popup.expanded
                }
            }
        }

        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: -15
            text: popup.expanded ? "" : ""
            visible: MediaData.otherPlayers.length != 0
            color: "white"
            font.pointSize: 22

            TapHandler {
                acceptedButtons: Qt.LeftButton
                onTapped: popup.expanded = !popup.expanded
            }
        }
    }
}