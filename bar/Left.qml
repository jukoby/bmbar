import QtQuick
import QtQuick.Layouts
import qs.components.inhibit
import qs.components.power
import qs.components.tray
import qs.components.workspace

RowLayout {
    spacing: 12

    PowerButton {}

    InhibitButton {}

    Workspaces {}

    Tray {}
}
