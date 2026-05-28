pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    function getMonitorWorkspaces(screen) {
        return Hyprland.workspaces.values.filter(
            workspace => workspace.monitor?.id === Hyprland.monitorFor(screen)?.id
        )
    }

    function hasFullscreenOnScreen(screen) {
        return Hyprland.toplevels.values.some(
            toplevel => toplevel.monitor == Hyprland.monitorFor(screen) && toplevel.wayland.fullscreen
        )
    }
}
