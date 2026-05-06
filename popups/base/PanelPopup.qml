pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Shapes
import qs.data

Loader {
    id: loader
    active: false
    visible: active
    
    required property var contentItem
    property int customHeight
    property bool rightSide: !leftSide
    property bool leftSide: !rightSide
    property bool maskEnabled: false
    property bool disableHeightAnimation: false

    function toggle() {
        active ? item.close = true : active = true
    }

    sourceComponent : PanelWindow {
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

        readonly property int realHeight: loader.customHeight ? 
            loader.customHeight + panel.heightPadding :
            loader.contentItem.height + panel.heightPadding
        readonly property int heightPadding: 10
        readonly property int borderRadius: 20
        readonly property int animationPadding: loader.contentItem.width / 5
        readonly property string backgroundColor: "#111"
        property bool close: false

        Region {
            id: maskRegion
            width: backgroundRect.width
            height: backgroundRect.height
            x: loader.rightSide ? Screen.width - backgroundRect.width + panel.animationPadding : 0
        }

        anchors {
            top: true
            right: loader.rightSide
            left: loader.leftSide
        }

        onCloseChanged: {
            // change animation properties, they will reset once the panel is unloaded
            animation.easing.type = Easing.InBack
            const oldFrom = animation.from
            animation.from = animation.to
            animation.to = oldFrom
            animation.start()
        }

        // Bar closes when a click is registered outside of it
        MouseArea {
            anchors.fill: parent
            onPressed: panel.close = true
        }

        Item {
            PropertyAnimation on x {
                id: animation
                easing.type: Easing.OutBack
                from: loader.rightSide ? Screen.width + backgroundRect.width - panel.animationPadding : -backgroundRect.width
                duration: 300
                to: loader.rightSide ?  Screen.width - backgroundRect.width + panel.animationPadding : 0
                onFinished: {
                    if (panel.close) {
                        // unload the panel once the animation is finished
                        loader.active = false
                    }
                }
            }

            Shape {
                preferredRendererType: Shape.CurveRenderer
                x: loader.rightSide ? 1 : loader.contentItem.width - 1

                ShapePath {
                    strokeWidth: 0
                    fillColor: panel.backgroundColor
                    
                    PathAngleArc {
                        moveToStart: false
                        centerX: loader.rightSide ? -panel.borderRadius : panel.borderRadius
                        centerY: panel.borderRadius
                        radiusX: centerX
                        radiusY: panel.borderRadius
                        startAngle: 180
                        sweepAngle: 90
                    }
                }
            }

            Rectangle {
                id: backgroundRect
                color: panel.backgroundColor
                x: loader.rightSide ? 0 : -panel.animationPadding + 1
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
