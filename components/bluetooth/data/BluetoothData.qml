pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton { 
    readonly property BluetoothAdapter defaultAdapter: Bluetooth.defaultAdapter // qmllint disable unresolved-type
    readonly property list<BluetoothDevice> devices: defaultAdapter?.devices?.values ?? [] // qmllint disable unresolved-type
    readonly property BluetoothDevice activeDevice: devices.find(d => d.connected) ?? null

    enum Status {
        Enabled,
        Disabled,
        Searching,
        Connected
    }
    property int status: getStatus()
    
    function getStatus() {
        switch (defaultAdapter.state) { // qmllint disable unresolved-type
            case BluetoothAdapterState.Disabled:
            case BluetoothAdapterState.Disabling:
            case BluetoothAdapterState.Blocked:
            return BluetoothData.Status.Disabled 
        }

        if (activeDevice) {
            return BluetoothData.Status.Connected
        }

        if (defaultAdapter.discovering) {
            return BluetoothData.Status.Searching
        }

        return BluetoothData.Status.Enabled
    }
}
