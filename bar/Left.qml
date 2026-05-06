import QtQuick
import QtQuick.Layouts
import qs.bar.components
import qs.bar.components.workspace
import qs.bar.components.tray

RowLayout {
    id: bar
    spacing: 10
    Layout.leftMargin: 10

    PowerButton {}

    Inhibit {}

    Workspaces {}

    Tray {}

}