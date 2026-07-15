import QtQuick
import QtQuick.Layouts
import qs.components.audio
import qs.components.bluetooth
import qs.components.colorpicker
import qs.components.date
import qs.components.nightlight
import qs.components.notification
import qs.components.update

RowLayout {
    spacing: 12

    UpdateButton {}

    ColorPickerButton {}

    NightLightButton {}

    BluetoothButton {}

    NotifButton {}

    AudioButton { Layout.leftMargin: 10 }

    DateButton { }
}
