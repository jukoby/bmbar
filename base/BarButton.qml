import QtQuick
import QtQuick.Layouts
import qs.theme

Text {
    id: barButton
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    color: Theme.primary
    property bool fixedSize: true

    signal leftClicked()

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: barButton.leftClicked()
        margin: 5
    }

    Component.onCompleted: {
        if (fixedSize) Layout.preferredWidth = contentWidth
    }
}
