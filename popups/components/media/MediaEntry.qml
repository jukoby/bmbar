pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Services.Mpris

RowLayout {
    id: root
    Layout.fillWidth: true

    required property MprisPlayer player
    property int imageSize: 100

    Item {
        Layout.preferredWidth: root.imageSize
        Layout.preferredHeight: root.imageSize
        Layout.leftMargin: 10

        ClippingRectangle {
            anchors.centerIn: parent
            width: parent.width
            height: image.paintedHeight
            color: "transparent"
            radius: 10

            Image {
                id: image
                anchors.centerIn: parent
                width: root.imageSize
                height: root.imageSize
                source: root.player.trackArtUrl
                sourceSize.width: 128
                sourceSize.height: 128
                fillMode: Image.PreserveAspectFit
                mipmap: true
                asynchronous: true
                cache: true
            }
        }
    }

    ColumnLayout {
        id: info
        spacing: 1
        Layout.preferredWidth: 310
        Layout.leftMargin: 10
        Layout.rightMargin: Layout.leftMargin

        Text {
            Layout.preferredWidth: info.width
            text: root.player.trackTitle
            color: "white"
            elide: Text.ElideRight
            font.bold: true
        }

        Text {
            Layout.preferredWidth: info.width
            text: root.player.trackArtist
            color: "white"
            elide: Text.ElideRight
        }

        Text {
            Layout.preferredWidth: info.width
            text: root.player.trackAlbum ? root.player.trackAlbum : root.player.desktopEntry
            color: "white"
            elide: Text.ElideRight
        }
    }
}