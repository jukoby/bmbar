pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.data
import qs.bar.components.base

Loader {
    id: loader
    active: false
    visible: active

    required property int side
    required property var contentItem
    property int borderRadius: 20
    property Region mask

    function toggle() {
        active ? item.close = true : active = true
    }

    sourceComponent: PanelWindow {
        id: panel
        visible: true
        color: "transparent"
        // Resizing a PanelWindow causes visual artifacts
        implicitWidth: Screen.width
        implicitHeight: Screen.height
        mask: loader.mask

        margins { // qmllint disable unresolved-type
            top: HyprlandController.hasFullscreenOnScreen(screen) ? -30 : 0
        }

        anchors.top: true
        anchors.left: loader.side === Side.LEFT
        anchors.right: loader.side !== Side.LEFT

        property bool close: false
        property int animationPadding: loader.contentItem.width * 0.2

        onCloseChanged: {
            // change animation properties, they will reset once the panel is unloaded
            const animation = loader.side === Side.CENTER ? animationV : animationH
            if (loader.side !== Side.CENTER) {
                animation.easing.type = Easing.InBack;
            }
            const oldFrom = animation.from
            animation.from = animation.to
            animation.to = oldFrom
            animation.start()
        }

        Row {
            anchors.right: loader.side === Side.RIGHT ? parent.right : undefined
            anchors.horizontalCenter: loader.side === Side.CENTER ? parent.horizontalCenter : undefined
            spacing: -1

            Corner {
                id: leftCorner
                size: loader.borderRadius
                visible: loader.side !== Side.LEFT
                rightSide: true
            }

            Rectangle {
                id: backgroundRect
                children: [loader.contentItem]
                color: "#111"
                bottomLeftRadius: loader.side !== Side.LEFT ? loader.borderRadius : 0
                bottomRightRadius: loader.side !== Side.RIGHT ? loader.borderRadius : 0
                implicitWidth: loader.contentItem.width + (loader.side === Side.CENTER ? 0 : panel.animationPadding)
                implicitHeight: loader.contentItem.height + 10

                Behavior on implicitHeight { 
                    NumberAnimation {
                        duration: 150
                    }
                }

                Component.onCompleted: {
                    if (loader.side === Side.LEFT) {
                        loader.contentItem.anchors.right = backgroundRect.right
                    }
                }
            }

            Corner {
                id: rightCorner
                size: loader.borderRadius
                visible: loader.side !== Side.RIGHT
                leftSide: true
            }

            
            transform: loader.side === Side.CENTER ? translateV : translateH
            
            Translate {
                id: translateH
                PropertyAnimation on x {
                    id: animationH
                    from: backgroundRect.width * (loader.side === Side.RIGHT ? 1 : -1)
                    to: panel.animationPadding * (loader.side === Side.RIGHT ? 1 : -1)
                    duration: 300
                    easing.type: Easing.OutBack

                    onFinished: {
                        if (panel.close) {
                            // unload the panel once the animation is finished
                            loader.active = false
                        }
                    }
                }
            }

            Translate {
                id: translateV
                PropertyAnimation on y {
                    id: animationV
                    from: -backgroundRect.height
                    to: 0
                    duration: 300
                    easing.type: Easing.InOutExpo

                    onFinished: {
                        if (panel.close) {
                            // unload the panel once the animation is finished
                            loader.active = false
                        }
                    }
                }
            }
        }

        // Bar closes when a click is registered outside of it
        TapHandler {
            acceptedButtons: Qt.LeftButton
            onTapped: (event) => panel.close = !backgroundRect.contains(
                backgroundRect.mapFromGlobal(event.position.x, event.position.y)
            )
        }
    }
}
