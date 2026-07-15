import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import qs.base
import qs.theme

Rectangle {
    id: container
    anchors.horizontalCenter: parent?.horizontalCenter
    color: Theme.bgAlt
    radius: 10

    required property Notification modelData

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: {
            const primaryAction = container.modelData.actions[0] // qmllint disable unresolved-type
            if (primaryAction) {
                primaryAction.invoke()
            }
        }
    }

    GridLayout {
        columns: 2
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        rowSpacing: 0

        ThemedText {
            id: summary
            font.bold: true
            elide: Text.ElideRight

            Layout.fillWidth: true
            Layout.maximumWidth: container.width - 20
        }

        ThemedText {
            text: ""
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            TapHandler {
                acceptedButtons: Qt.LeftButton
                onTapped: container.dismiss()
            }
        }

        ThemedText {
            id: body
            font.pointSize: 10
            wrapMode: Text.WordWrap
            elide: Text.ElideRight
            maximumLineCount: 3
            
            Layout.columnSpan: 2
            Layout.maximumWidth: container.width - 20
        }

        Component.onCompleted: {
            body.text = container.modelData.body
            summary.text = container.modelData.summary
        }
    }

    function dismiss() { dismissAction.start() }
    
    Timer {
        id: dismissAction
        interval: scaleAnim.duration
        onRunningChanged: {
            scaleAnim.from = 1
            scaleAnim.to = 0
            scaleAnim.start()
        }
        onTriggered: {
            container.modelData.dismiss()
        }
    }

    NumberAnimation on scale {
        id: scaleAnim
        from: 0
        to: 1
        duration: 150
        running: true
    }
}
