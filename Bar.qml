import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.bar

Scope {
    id: root
    
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barWindow
            required property ShellScreen modelData
            screen: modelData
            implicitHeight: 50
            exclusiveZone: 30
            mask: Region { item: bar }
            color: 'transparent'

            anchors {
                top: true
                left: true
                right: true
            }

            Corner {
                rightSide: false
            }

            Rectangle {
                id: bar
                color: '#111'
                width: barWindow.width
                height: 30
                
                RowLayout {
                    anchors.fill: parent
                    spacing: 10
                    uniformCellSizes: true

                    Left { Layout.alignment: Qt.AlignLeft }

                    Center { Layout.alignment: Qt.AlignCenter }

                    Right { Layout.alignment: Qt.AlignRight }
                }
            }

            Corner {
                rightSide: true
                screenSize: barWindow.screen.width
            }
        }
    }
}
