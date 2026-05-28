import QtQuick
import QtQuick.Layouts
import qs.base
import qs.data
import qs.components.audio
import qs.components.bluetooth
import qs.components.colorpicker
import qs.components.nightlight
import qs.components.notification

RowLayout {
    spacing: 12

    ColorPickerButton {}

    NightLightButton {}

    NotifButton {}

    BluetoothButton {}

    AudioButton { Layout.leftMargin: 10 }

    BarButton { text: Time.time }
}
