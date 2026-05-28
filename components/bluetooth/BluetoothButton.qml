import QtQuick
import qs.base
import qs.components.bluetooth.data

BarButton {
    text: bluetoothIcon()

    function bluetoothIcon() {
        switch (BluetoothData.status) {
            case BluetoothData.Status.Enabled:
                return "󰂯"
            case BluetoothData.Status.Disabled:
                return "󰂲"
            case BluetoothData.Status.Searching:
                return "󰂰"
            case BluetoothData.Status.Connected:
                return "󰂱"
        }
    }

    BluetoothPopup { id: popup }

    onLeftClicked: popup.toggle()
}
