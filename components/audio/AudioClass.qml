pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire
import qs.theme
import qs.components.audio.data

ColumnLayout {
    id: deviceContainer
    required property list<PwNode> nodes
    required property string title
    required property int audioType
    property double max_volume: 1

    spacing: 2

    Text {
        color: Theme.primary
        text: deviceContainer.title
        font.bold: true
        visible: deviceContainer.nodes.length != 0
    }

    Repeater {
        model: deviceContainer.nodes

        RowLayout {
            id: device
            required property PwNode modelData

            PwObjectTracker {
                objects: [device.modelData]
            }

            RadioButton {
                id: radioButton
                implicitHeight: 15
                implicitWidth: implicitHeight
                checked: AudioData.isDefault(
                    deviceContainer.audioType, device.modelData
                )
                onClicked: AudioData.setDefault(
                    deviceContainer.audioType, device.modelData
                )
                visible: deviceContainer.audioType !== AudioType.Stream
            }

            Text {
                Layout.preferredWidth: 155
                Layout.leftMargin: deviceContainer.audioType !== AudioType.Stream ? 0 : 20
                color: Theme.primary
                elide: Text.ElideRight
                text: device.modelData.description.length == 0 
                    ? device.modelData.name 
                    : device.modelData.description
                
                TapHandler {
                    acceptedButtons: Qt.LeftButton
                    onTapped: radioButton.click()
                }
            }

            Slider {
                id: slider
                Layout.preferredWidth: 200
                from: 0
                value: device.modelData.audio.volume
                onMoved: device.modelData.audio.volume = value
                to: deviceContainer.max_volume
            }

            Text {
                color: Theme.primary
                text: (device.modelData.audio.volume * 100).toFixed(0) + " %"
            }
        }
    }
}
