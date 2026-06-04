pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets 
import qs.base
import qs.components.date.data


PanelPopup {
    id: popup
    side: Side.RIGHT

    contentItem: WrapperItem {
        rightMargin: 10
        leftMargin: rightMargin

        GridLayout {
            columns: 3

            Text {
                text: Qt.locale().monthName(Time.month)
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            VerticalLine {
                Layout.rowSpan: 2
                Layout.margins: 5
            }

            DayOfWeekRow {
                locale: grid.locale

                Layout.column: 2
                Layout.fillWidth: true
            }

            WeekNumberColumn {
                id: test
                month: grid.month
                year: grid.year
                locale: grid.locale
                delegate: Text {
                    text: weekNumber
                    color: "white"
                    font.italic: true

                    required property int weekNumber
                }

                Layout.fillHeight: true
            }


            MonthGrid {
                id: grid
                month: Time.month
                year: Time.year
                delegate: Label {
                    id: label
                    required property var model

                    text: model.day
                    font.bold: model.today
                    color: "white"
                    opacity: model.month == Time.month ? 1 : 0.25
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    background: Rectangle {
                        color: label.model.today ? "white" : "transparent"
                        opacity: 0.2
                        radius: 5
                    }
                }

                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
