import QtQuick
import qs.data
import qs.popups
import qs.popups.components.base

IconPercent {
    icons: [" ", " ", ""]
    steps: [10, 30]
    value: AudioController.volume
    multiplier: 100
    fallback: AudioController.defaultSink?.audio?.muted ?
        " " : ""
    
    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: popup.toggle()
    }

    AudioPopup { id: popup }
}
