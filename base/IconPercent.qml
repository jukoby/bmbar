import QtQuick
import QtQuick.Layouts
import qs.theme

RowLayout {
    id: root
    required property list<string> icons
    required property list<int> steps
    required property double value
    property int multiplier: 1
    property string alternative
    property bool bold
    property int iconWidth: 16
    property int textWidth: 32

    Text {
        text: root.alternative ? root.alternative : getIcon()
        color: Theme.primary
        font.bold: root.bold
        horizontalAlignment: Qt.AlignLeft
        Layout.preferredWidth: root.iconWidth

        function getIcon() {
            const index = root.steps.findIndex(
                (step) => root.value * root.multiplier < step
            )
            return index !== -1 ? 
                root.icons[index] : root.icons[root.icons.length - 1]
        }
    }
    
    Text {
        text: `${(root.value * root.multiplier).toFixed(0)}%`
        color: Theme.primary
        font.bold: root.bold
        font.pointSize: root.value == 1 ? 10: 11
        horizontalAlignment: Qt.AlignRight
        Layout.preferredWidth: root.textWidth
    }
}
