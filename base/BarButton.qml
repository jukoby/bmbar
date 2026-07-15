import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ThemedText {
    id: barButton
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    property bool fixedSize: true
    property string tooltip

    signal leftClicked()

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: barButton.leftClicked()
        margin: 5
    }

    HoverHandler {
        id: hoverHandler
        enabled: barButton.tooltip
    }

    ToolTip {
        text: barButton.tooltip
        font.pointSize: 10
        visible: hoverHandler.hovered
        delay: 750
        enabled : barButton.tooltip
        x: - width - 5
    }

    Component.onCompleted: {
        if (fixedSize) Layout.preferredWidth = contentWidth
    }
}
