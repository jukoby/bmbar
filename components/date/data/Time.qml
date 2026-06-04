pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string time: Qt.formatDateTime(clock.date, "dd.MM.yyyy - hh:mm:ss")
    readonly property int year: clock.date.getFullYear()
    readonly property int month: clock.date.getMonth()

    SystemClock {
        id: clock
    }
}
