import QtQuick
import qs.data
import qs.bar.components.base
import qs.popups

BarButton {
    text: bluetoothIcon()

    function bluetoothIcon() {
        switch (BluetoothController.status) {
            case BluetoothController.Status.Enabled:
                return "󰂯"
            case BluetoothController.Status.Disabled:
                return "󰂲"
            case BluetoothController.Status.Searching:
                return "󰂰"
            case BluetoothController.Status.Connected:
                return "󰂱"
        }
    }

    BluetoothPopup { id: popup }

    onLeftClicked: popup.toggle()
}
