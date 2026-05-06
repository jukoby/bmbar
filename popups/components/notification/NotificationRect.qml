import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Notifications

Rectangle {
    id: container
    required property Notification modelData
    anchors.horizontalCenter: parent?.horizontalCenter

    color: "#222"
    radius: 10

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: {
            const primaryAction = container.modelData.actions[0]
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

        Text {
            id: summary
            Layout.fillWidth: true
            Layout.maximumWidth: container.width - 20
            color: "white"
            font.bold: true
            elide: Text.ElideRight
        }

        Text {
            text: ""
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            TapHandler {
                acceptedButtons: Qt.LeftButton
                onTapped: container.dismiss()
            }
        }

        Text {
            id: body
            Layout.columnSpan: 2
            Layout.maximumWidth: container.width - 20
            color: "white"
            font.pointSize: 10
            wrapMode: Text.WordWrap
            elide: Text.ElideRight
            maximumLineCount: 3
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