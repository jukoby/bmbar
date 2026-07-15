import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.base
import qs.theme
import qs.components.audio.data

RowLayout {
    id: device
    required property PwNode modelData
    required property int audioType
    property double max_volume: 1

    PwObjectTracker {
        objects: [device.modelData]
    }

    Label {
        id: label
        readonly property bool isSelected: AudioData.isDefault(
            device.audioType, device.modelData
        ) && device.audioType !== AudioType.Stream

        Layout.preferredWidth: 175
        color: Theme.primary
        elide: Text.ElideRight
        text: device.modelData.description.length == 0 
            ? device.modelData.name 
            : device.modelData.description
        font.bold: isSelected
        horizontalAlignment: Text.AlignHCenter 
        leftPadding: 5
        rightPadding: leftPadding
        background: Rectangle {
            color: label.isSelected ? Theme.bgAlt : "transparent"
            radius: 7
        }
        
        TapHandler {
            acceptedButtons: Qt.LeftButton
            onTapped: AudioData.setDefault(
                device.audioType, device.modelData
            )
        }
    }

    Slider {
        id: slider
        Layout.preferredWidth: 200
        from: 0
        value: device.modelData.audio.volume
        onMoved: device.modelData.audio.volume = value
        to: device.max_volume
    }

    ThemedText {
        text: (device.modelData.audio.volume * 100).toFixed(0) + " %"
    }
}