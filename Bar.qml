import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.bar
import qs.bar.components.base

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
                y: barWindow.exclusiveZone
                size: 20
                direction: Direction.SE
            }

            Rectangle {
                id: bar
                color: '#111'
                width: barWindow.width
                height: barWindow.exclusiveZone
                
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
                x: Screen.width - size
                y: barWindow.exclusiveZone
                size: 20
                direction: Direction.SW
            }
        }
    }
}
