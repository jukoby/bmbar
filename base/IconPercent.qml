import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    required property list<string> icons
    required property list<int> steps
    required property double value
    property int multiplier: 1
    property string alternative
    property bool bold

    Text {
        text: root.alternative ? root.alternative : getIcon()
        color: "white"
        font.bold: root.bold
        Layout.preferredWidth: 18

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
        color: "white"
        font.bold: root.bold
        Layout.preferredWidth: 32

        function getIcon() {
            const index = root.steps.findIndex(
                (step) => root.value * root.multiplier < step
            )
            return index !== -1 ? 
                root.icons[index] : root.icons[root.icons.length - 1]
        }
    }
}
