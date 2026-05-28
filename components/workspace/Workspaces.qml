import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.data

RowLayout {
    spacing: 5
    Layout.leftMargin: 2
    Layout.rightMargin: Layout.leftMargin

    Repeater {
        model: HyprlandData.getMonitorWorkspaces(QsWindow.window?.screen) // qmllint disable missing-property
        
        WorkspaceItem {}
    }
}