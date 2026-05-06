import QtQuick
import Quickshell
import qs.data
import qs.bar.components.base

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

    onLeftClicked: Quickshell.execDetached(["blueman-manager"])
}
