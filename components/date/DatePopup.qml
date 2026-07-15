pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import qs.theme
import qs.base
import qs.components.date.data


PanelPopup {
    id: popup
    side: Side.RIGHT

    contentItem: WrapperItem {
        rightMargin: 10
        leftMargin: rightMargin

        ColumnLayout {

            RowLayout {
                ThemedText {
                    text: ""

                    Layout.fillWidth: true


                    TapHandler {
                        acceptedButtons: Qt.LeftButton
                        onTapped: {
                            if (grid.month == 0) {
                                grid.month = 11
                                grid.year = grid.year - 1
                            } else {
                                grid.month = grid.month - 1
                            }
                        }
                    }
                }

                ThemedText {
                    text: Qt.locale().monthName(grid.month)
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    Layout.alignment: Qt.AlignHCenter
                }

                ThemedText {
                    text: ""
                    horizontalAlignment: Text.AlignRight

                    Layout.fillWidth: true

                    TapHandler {
                        acceptedButtons: Qt.LeftButton
                        onTapped: {
                            if (grid.month == 11) {
                                grid.month = 0
                                grid.year = grid.year + 1
                            } else {
                                grid.month = grid.month + 1
                            }
                        }
                    }
                }

                Layout.fillWidth: true
            }

            GridLayout {
                ThemedText {
                    text: grid.year
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    Layout.alignment: Qt.AlignHCenter
                    Layout.fillWidth: true
                }

                VerticalLine {
                    Layout.rightMargin: 5
                    Layout.rowSpan: 2
                }

                DayOfWeekRow {
                    id: dayOfWeek
                    locale: grid.locale

                    delegate: ThemedText {
                        text: shortName
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        required property string shortName
                    }

                    Layout.alignment: Qt.AlignRight
                    Layout.fillWidth: true
                }
            
                WeekNumberColumn {
                    id: test
                    month: grid.month
                    year: grid.year
                    locale: grid.locale
                    delegate: ThemedText {
                        text: weekNumber
                        font.italic: true
                        horizontalAlignment: Text.AlignRight

                        required property int weekNumber
                    }

                    Layout.column: 0
                    Layout.row: 1
                    Layout.alignment: Qt.AlignRight
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
                        color: Theme.primary
                        opacity: model.month == grid.month ? 1 : 0.25
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 3
                        rightPadding: 3

                        background: Rectangle {
                            color: label.model.today ? Theme.primary : "transparent"
                            opacity: 0.2
                            radius: 5
                        }
                    }

                    Layout.column: 2
                    Layout.row: 1
                    Layout.fillWidth: true
                }
            }
        }
    }
}
