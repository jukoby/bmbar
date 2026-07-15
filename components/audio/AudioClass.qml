pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.base

ColumnLayout {
    id: deviceContainer
    required property list<PwNode> nodes
    required property string title
    required property int audioType
    property double max_volume: 1

    spacing: 2

    ThemedText {
        text: deviceContainer.title
        font.bold: true
        visible: deviceContainer.nodes.length != 0
    }

    Repeater {
        model: deviceContainer.nodes

        AudioNode {
            audioType: deviceContainer.audioType
            max_volume: deviceContainer.max_volume
        }
    }
}
