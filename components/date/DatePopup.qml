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
                Text {
                    text: ""
                    color: Theme.primary

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

                Text {
                    text: Qt.locale().monthName(grid.month)
                    color: Theme.primary
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter

                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: ""
                    color: Theme.primary
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
                Text {
                    text: grid.year
                    color: Theme.primary
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

                    delegate: Text {
                        text: shortName
                        color: Theme.primary
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter

                        required property string shortName
                    }

                    Layout.alignment: Qt.AlignRight
                }
            
                WeekNumberColumn {
                    id: test
                    month: grid.month
                    year: grid.year
                    locale: grid.locale
                    delegate: Text {
                        text: weekNumber
                        color: Theme.primary
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
