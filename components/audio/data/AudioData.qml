pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import qs.components.audio.data

Singleton {
    id: audioData
    
    PwObjectTracker {
        objects: [
            audioData.defaultSink,
            audioData.defaultSource
        ]
    }

    property bool ready: Pipewire.defaultAudioSink?.ready ?? false
    property PwNode defaultSink: Pipewire.defaultAudioSink
    property PwNode defaultSource: Pipewire.defaultAudioSource
    property list<PwNode> nodes: Pipewire.nodes.values
    property list<PwNode> outputs: nodes.filter((node) => node.isSink && !node.isStream)
    property list<PwNode> inputs: nodes.filter((node) => node.audio && !node.isSink && !node.isStream)
    property list<PwNode> streams: nodes.filter((node) => node.isSink && node.isStream)

    readonly property double volume: defaultSink ? defaultSink.audio.volume : 0

    function isDefault(audioType, node) {
        switch (audioType) {
            case AudioType.Output:
                return defaultSink === node
            case AudioType.Input:
                return defaultSource === node
            default:
                return true
        }
    }

    function setDefault(audioType, node) {
        switch (audioType) {
            case AudioType.Output:
                Pipewire.preferredDefaultAudioSink = node
                break
            case AudioType.Input:
                Pipewire.preferredDefaultAudioSource = node
                break
            default:
                break
        }
    }
}
