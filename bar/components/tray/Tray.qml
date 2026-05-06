import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

RowLayout {
    spacing: 5
    Repeater {
        model: SystemTray.items
        
        TrayButton {}
    }
}