pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string primary
    property string highlight
    property string bg
    property string bgAlt

    Component.onCompleted: update()

    FileView {
        id: jsonFile
        path: Qt.resolvedUrl("./colors.json")
        blockLoading: true
        watchChanges: true
        printErrors: false
        onFileChanged: this.reload()
        onLoaded: root.update()
    }

    function update() {
        const config = (() => {
            try {
                return JSON.parse(jsonFile.text());
            } catch (error) {
                return null;
            }
        })()
        root.primary = config?.primary ?? "#fff"
        root.highlight = config?.highlight ?? "#24a0ed"
        root.bg = config?.bg ?? "#111"
        root.bgAlt = config?.bgAlt ?? "#555"
    }
}