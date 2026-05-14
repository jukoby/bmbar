pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.data

PanelWindow {
    id: panel
    visible: true
    color: "transparent"
    // Resizing a PanelWindow causes visual artifacts
    implicitHeight: Screen.height
    implicitWidth: Screen.width
    margins {
        top: HyprlandController.hasFullscreenOnScreen(screen) ? -30 : 0
    }
    
    mask: loader.maskEnabled ? maskRegion : null

    readonly property int borderRadius: 20
    readonly property string backgroundColor: "#111"
    property bool close: false
    readonly property int realHeight: loader.customHeight ? 
        loader.customHeight + panel.heightPadding :
        loader.contentItem.height + panel.heightPadding
    readonly property int heightPadding: 10
    readonly property int animationPadding: loader.contentItem.width / 5

    required property int x
    required property PopupLoader loader
    required property PropertyAnimation animation

    onCloseChanged: {
        // change animation properties, they will reset once the panel is unloaded
        animation.easing.type = Easing.InBack;
        const oldFrom = animation.from
        animation.from = animation.to
        animation.to = oldFrom
        // [animation.from, animation.to] = [animation.to, animation.from] // causes problems
        animation.start()
    }

    Region {
        id: maskRegion
        width: panel.loader.contentItem.width + panel.animationPadding
        height: panel.realHeight
        x: panel.x
    }

    anchors {
        top: true
        right: loader.rightSide
        left: loader.leftSide
    }

    // Bar closes when a click is registered outside of it
    MouseArea {
        anchors.fill: parent
        onPressed: panel.close = true
    }

}