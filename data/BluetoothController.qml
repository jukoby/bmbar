pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton { 
    readonly property BluetoothAdapter defaultAdapter: Bluetooth.defaultAdapter
    readonly property list<BluetoothDevice> devices: defaultAdapter?.devices?.values ?? []
    readonly property BluetoothDevice activeDevice: devices.find(d => d.connected) ?? null
    // TODO Battery Info of active Device

    enum Status {
        Enabled,
        Disabled,
        Searching,
        Connected
    }
    property int status: getStatus()
    
    function getStatus() {
        if (!defaultAdapter?.enabled) {
            return BluetoothController.Status.Disabled
        }

        if (activeDevice) {
            return BluetoothController.Status.Connected
        }

        if (defaultAdapter.discovering) {
            return BluetoothController.Status.Searching
        }
        return BluetoothController.Status.Enabled
    }
}