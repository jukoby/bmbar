import QtQuick
import qs.base
import qs.components.audio.data

IconPercent {
    icons: [" ", " ", ""]
    steps: [10, 30]
    value: AudioData.volume
    multiplier: 100
    fallback: AudioData.defaultSink?.audio?.muted ?
        " " : ""
    
    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: popup.toggle()
    }

    Item {
        AudioPopup { id: popup }
    }
}
