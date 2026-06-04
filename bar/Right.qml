import QtQuick
import QtQuick.Layouts
import qs.components.audio
import qs.components.bluetooth
import qs.components.colorpicker
import qs.components.nightlight
import qs.components.notification
import qs.components.date

RowLayout {
    spacing: 12

    ColorPickerButton {}

    NightLightButton {}

    BluetoothButton {}

    NotifButton {}

    AudioButton { Layout.leftMargin: 10 }

    DateButton { }
}
