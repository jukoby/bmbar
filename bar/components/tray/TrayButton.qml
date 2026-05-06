import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray


IconImage {
    id: trayIcon
    required property SystemTrayItem modelData
    source: modelData.icon
    implicitSize: 20

    TapHandler {
        // TODO: touch support?
        acceptedButtons: Qt.LeftButton
        onTapped: trayIcon.modelData.activate()
    }

    TapHandler {
        acceptedButtons: Qt.RightButton
        onTapped: qsMenu.open()
    }

    TapHandler {
        acceptedButtons: Qt.MiddleButton
        onTapped: trayIcon.modelData.secondaryActivate()
    }

    QsMenuAnchor {
        id: qsMenu    
        menu: trayIcon.modelData.menu
        anchor.item: trayIcon
        anchor.edges: Edges.Bottom
    }
}
