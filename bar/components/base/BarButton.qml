import QtQuick
import QtQuick.Layouts

Text {
    id: barButton
    property bool fixedSize: true
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    color: "white"
    signal leftClicked()

    TapHandler {
        acceptedButtons: Qt.LeftButton
        onTapped: barButton.leftClicked()
        margin: 5
    }

    Component.onCompleted: {
        if (fixedSize) {
            Layout.preferredWidth = contentWidth
        }
    }
}
