import QtQuick
import qs.data
import qs.bar.components.base
import qs.popups

BarButton {
    text: volumeIcon() + " " + volumeString()
    onLeftClicked: popup.toggle()
    fixedSize: false

    AudioPopup { id: popup }

    function volumeString() {
        return AudioController.getVolume() + "%"
    }

    function volumeIcon() {
        if (AudioController.defaultSink?.audio?.muted) {
            return " "
        }
        const volume = AudioController.getVolume()
        if (volume < 10) {
            return " "
        } else if (volume < 30) {
            return " "
        }
        return ""
    }
}
