import QtQuick
import QtQuick.Layouts
import qs.data
import qs.bar.components
import qs.base

RowLayout {
    spacing: 10

    AudioButton {}

    Bluetooth {}

    ColorPicker {}

    NightLight {}

    NotificationButton {}

    BarButton {
        text: Time.time
    }
}
