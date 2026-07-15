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

    ThemedLabel {
        id: label
        applyBackground: AudioData.isDefault(
            device.audioType, device.modelData
        ) && device.audioType !== AudioType.Stream
        elide: Text.ElideRight
        text: device.modelData.description.length == 0 
            ? device.modelData.name 
            : device.modelData.description
        horizontalAlignment: Text.AlignHCenter 
        leftPadding: 5
        rightPadding: leftPadding

        Layout.preferredWidth: 175
        
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