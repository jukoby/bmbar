pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import qs.base
import qs.data
import qs.theme

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

    sourceComponent: PopupWindow {
        id: panel
        visible: true
        color: "transparent"
        // Resizing a Window causes visual artifacts
        implicitWidth: QsWindow.window.width // qmllint disable missing-property
        implicitHeight: Screen.height
        mask: loader.mask
        property int topMargin: HyprlandData.hasFullscreenOnScreen(screen) ? 0 : 30

        anchor {
            window: QsWindow.window
            rect.y: topMargin
            adjustment: PopupAdjustment.None // qmllint disable missing-type
        }

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
            anchors.horizontalCenter: loader.side === Side.CENTER ? parent.horizontalCenter : undefined
            anchors.left: loader.side === Side.LEFT ? parent.left : undefined // qmllint disable Quick.anchor-combinations
            anchors.right: loader.side === Side.RIGHT ? parent.right : undefined
            spacing: -0.5

            Corner {
                id: leftCorner
                size: loader.borderRadius
                visible: loader.side !== Side.LEFT
                direction: Direction.SW
            }

            Rectangle {
                id: backgroundRect
                children: [loader.contentItem]
                color: Theme.bg
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
                direction: Direction.SE
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
                backgroundRect.mapFromGlobal(
                    event.position.x, event.position.y + panel.topMargin
                )
            )
        }
    }
}
