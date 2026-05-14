pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire
import qs.data

ColumnLayout {
    id: deviceContainer
    required property list<PwNode> nodes
    required property string title
    required property int audioType
    property double max_volume: 1

    spacing: 2

    Text {
        color: "white"
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
                checked: AudioController.isDefault(
                    deviceContainer.audioType, device.modelData
                )
                onClicked: AudioController.setDefault(
                    deviceContainer.audioType, device.modelData
                )
                visible: deviceContainer.audioType !== AudioType.Stream
            }

            Text {
                Layout.preferredWidth: 155
                Layout.leftMargin: deviceContainer.audioType !== AudioType.Stream ? 0 : 20
                color: "white"
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
                color: "white"
                text: (device.modelData.audio.volume * 100).toFixed(0) + " %"
            }
        }
    }
}
