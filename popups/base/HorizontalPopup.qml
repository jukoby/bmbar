pragma ComponentBehavior: Bound
import QtQuick
import qs.bar.components.base

PopupLoader {
    id: loader

    sourceComponent: BasePanelPopup {
        id: panel
        loader: loader
        animation: animation
        x: position.x

        property var position: loader.rightSide ? {
            x: Screen.width - backgroundRect.width + panel.animationPadding,
            hiddenX: Screen.width + backgroundRect.width - panel.animationPadding,
            cornerX: 1,
            bgRectX: 0,
        } : {
            x: 0,
            hiddenX: -backgroundRect.width,
            cornerX: loader.contentItem.width - 1,
            bgRectX: -panel.animationPadding,
        }

        Item {
            PropertyAnimation on x {
                id: animation
                from: panel.position.hiddenX
                to: panel.position.x
                duration: 300
                easing.type: Easing.OutBack

                onFinished: {
                    if (panel.close) {
                        // unload the panel once the animation is finished
                        loader.active = false
                    }
                }
            }

            Corner {
                x: panel.position.cornerX
                size: panel.borderRadius
                rightSide: loader.rightSide
            }

            Rectangle {
                id: backgroundRect
                color: panel.backgroundColor
                x: panel.position.bgRectX
                implicitWidth: loader.contentItem.width + panel.animationPadding
                implicitHeight: panel.realHeight
                Behavior on implicitHeight { 
                    enabled: !loader.disableHeightAnimation
                    NumberAnimation {
                        duration: 150
                    }
                }
                bottomLeftRadius: loader.rightSide ? panel.borderRadius : 0
                bottomRightRadius: loader.leftSide ? panel.borderRadius : 0
            }
            
            MouseArea {
                children: [loader.contentItem]
                width: backgroundRect.width
                height: backgroundRect.height
            }
        }
    }
}