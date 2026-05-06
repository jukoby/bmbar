import QtQuick
import QtQuick.Layouts
import qs.data
import qs.bar.components
import qs.bar.components.base

RowLayout {
    spacing: 12
    Layout.rightMargin: 5

    AudioButton {}

    Bluetooth {}

    ColorPicker {}

    NightLight {}

    NotificationButton {}

    BarButton {
        text: Time.time
    }
}
