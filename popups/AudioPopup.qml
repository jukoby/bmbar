pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.data
import qs.popups.base
import qs.popups.components.audio

PanelPopup {
    id: popup
    side: Side.RIGHT

    contentItem: Item {
        implicitHeight: layout.implicitHeight + 10
        implicitWidth: 450
        
        ColumnLayout {
            id: layout
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            AudioClass {
                nodes: AudioController.outputs
                title: "Audio Outputs"
                audioType: AudioType.Output
            }

            AudioClass {
                nodes: AudioController.inputs
                title: "Audio Inputs"
                audioType: AudioType.Input
                max_volume: 1.5
            }

            AudioClass {
                nodes: AudioController.streams
                title: "Current Streams"
                audioType: AudioType.Stream
            }
        }
    }
}
