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
    
    readonly property int borderRadius: 20
    readonly property string backgroundColor: "#111"
    property bool close: false
    readonly property int realHeight: loader.customHeight ? 
        loader.customHeight + panel.heightPadding :
        loader.contentItem.height + panel.heightPadding
    readonly property int heightPadding: 10
    readonly property int animationPadding: loader.contentItem.width / 5

    required property var position
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

    anchors {
        top: true
        right: loader.rightSide
        left: loader.leftSide
    }

    // Bar closes when a click is registered outside of it
    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: (event) => {
            panel.close = (event.position.x < panel.position.x 
                || event.position.x > panel.position.x + panel.loader.contentItem.width) || 
                (event.position.y > panel.realHeight)
        }
    }
}
