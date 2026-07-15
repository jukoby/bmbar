pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import Quickshell.Services.Mpris
import qs.base

RowLayout {
    id: root
    Layout.fillWidth: true

    required property MprisPlayer player
    property int imageSize: 100

    NumberAnimation on scale {
        from: 0
        to: 1
        duration: 150
        running: root.visible
    }

    Item {
        Layout.preferredWidth: root.imageSize
        Layout.preferredHeight: root.imageSize
        Layout.leftMargin: 10
        visible: image.status != Image.Null

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
                source: root.player?.trackArtUrl ?? "" // qmllint disable incompatible-type
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
        Layout.minimumWidth: 310
        Layout.fillWidth: true
        Layout.leftMargin: 10
        Layout.rightMargin: Layout.leftMargin

        ThemedText {
            Layout.fillWidth: true
            text: root.player?.trackTitle ?? ""
            elide: Text.ElideRight
            font.bold: true
        }

        ThemedText {
            Layout.fillWidth: true
            text: root.player?.trackArtist ?? ""
            elide: Text.ElideRight
        }

        ThemedText {
            Layout.fillWidth: true
            text: root.player?.trackAlbum ? root.player?.trackAlbum : root.player?.desktopEntry ?? ""
            elide: Text.ElideRight
        }

        ProgressBar {
            Layout.fillWidth: true
            Layout.preferredHeight: 5
            Layout.topMargin: 5
            from: 0
            to: root.player?.length ?? 0
            value: root.player?.position ?? 0
        }

        Timer {
            running: root.player?.playbackState == MprisPlaybackState.Playing
            interval: 1000
            repeat: true
            onTriggered: root.player.positionChanged()
        }

        RowLayout {
            Layout.preferredWidth: info.width

            ThemedText {
                text: new Date((root.player?.position ?? 0) * 1000).toISOString().slice(14, 19)
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                ThemedText {
                    text: ""
                    font.pointSize: 15

                    TapHandler {
                        acceptedButtons: Qt.LeftButton
                        onTapped: root.player.previous()
                    }
                }

                ThemedText {
                    Layout.preferredWidth: 25
                    horizontalAlignment: Text.AlignHCenter
                    text: root.player?.isPlaying ? "" : ""
                    font.pointSize: 15

                    TapHandler {
                        acceptedButtons: Qt.LeftButton
                        onTapped: root.player.togglePlaying()
                    }
                }

                ThemedText {
                    text: ""
                    font.pointSize: 15

                    TapHandler {
                        acceptedButtons: Qt.LeftButton
                        onTapped: root.player.next()
                    }
                }
            }

            ThemedText {
                Layout.alignment: Qt.AlignRight
                text: new Date((root.player?.length ?? 0) * 1000).toISOString().slice(14, 19)
            }
        }
    }
}