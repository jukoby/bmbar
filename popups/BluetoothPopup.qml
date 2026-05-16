pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Bluetooth 
import qs.popups.base
import qs.popups.components.bluetooth
import qs.popups.components.base


HorizontalPopup {
    id: popup
    rightSide: true

    contentItem: Item {
        id: root
        implicitHeight: layout.implicitHeight + 10
        implicitWidth: 350

        property var devices: Bluetooth.devices.values // qmllint disable unresolved-type
        property BluetoothAdapter defaultAdapter: Bluetooth.defaultAdapter // qmllint disable unresolved-type
        
        ColumnLayout {
            id: layout
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Repeater {
                id: connected
                model: root.devices.filter((device) => device.connected)

                BluetoothEntry { count: connected.count }
            }

            HorizontalLine { visible: paired.count > 0 && connected.count > 0 }

            Repeater {
                id: paired
                model: root.devices.filter((device) => !device.connected && device.paired)

                BluetoothEntry { count: paired.count  }
            }

            HorizontalLine { }

            RowLayout {
                Text {
                    text: "Search "
                    color: "white"

                    TapHandler {
                        acceptedButtons: Qt.LeftButton
                        onTapped: discover.running ? discover.stop() : discover.start()
                    }

                    Timer {
                        id: discover
                        interval: 10000
                        onRunningChanged: root.defaultAdapter.discovering = !root.defaultAdapter.discovering
                    }
                }

                BusyIndicator {
                    Layout.preferredWidth: 25
                    Layout.preferredHeight: 25

                    running: root.defaultAdapter.discovering
                }

            }

            Repeater {
                id: found
                model: root.devices.filter((device) => !device.connected && !device.paired)

                BluetoothEntry { count: found.count  }
            }

        }
    }
}
