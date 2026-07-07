import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Bluetooth
import qs.theme
import qs.base

RowLayout {
    id: device
    Layout.leftMargin: 15
    Layout.rightMargin: 10

    required property BluetoothDevice modelData
    required property int index
    required property int count

    RowLayout {
        Text {
            text: device.modelData.connected ? "󰌺" : "󰌹"
            color: Theme.primary
            font.bold: device.modelData.connected
        }

        Text {
            text: device.modelData.deviceName ? 
                device.modelData.deviceName :
                device.modelData.address
            color: Theme.primary
            font.bold: device.modelData.connected
        }

        TapHandler {
            acceptedButtons: Qt.LeftButton
            onTapped: device.modelData.connected ? 
                device.modelData.disconnect() :
                device.modelData.connect()
        }
    }

    VerticalLine { visible: device.modelData.batteryAvailable }

    IconPercent {
        icons: ["󰁻", "󰁾", "󰂁", "󰁹"]
        steps: [30, 60, 80]
        multiplier: 100
        value: device.modelData.battery
        bold: device.modelData.connected
        visible: device.modelData.batteryAvailable

        Layout.leftMargin: -3
    }
    
    VerticalLine { visible: device.modelData.bonded || device.modelData.trusted || device.modelData.connected }

    Text {
        text: ""
        color: Theme.primary
        font.bold: device.modelData.connected
        visible: device.modelData.bonded
    }

    Text {
        text: device.modelData.trusted ? "" : ""
        color: Theme.primary
        font.bold: device.modelData.connected

        TapHandler {
            acceptedButtons: Qt.LeftButton
            onTapped: device.modelData.trusted = !device.modelData.trusted 
        }
    }

    BusyIndicator {
        Layout.preferredWidth: 25
        Layout.preferredHeight: 25

        running: device.modelData.state == // qmllint disable unresolved-type
            BluetoothDeviceState.Connecting || BluetoothDeviceState.Disconnected
    }

    Text {
        text: "󰅖"
        color: Theme.primary
        font.bold: device.modelData.connected
        visible: device.modelData.bonded
        horizontalAlignment: Qt.AlignRight
        Layout.fillWidth: true

        TapHandler {
            acceptedButtons: Qt.LeftButton
            onTapped: device.modelData.forget()
        }
    }

    NumberAnimation on scale {
        from: 0
        to: 1
        duration: 150
        running: device.index == device.count - 1
    }
}