import QtQuick

Text {
    required property var icons
    required property var steps
    required property double value
    property int multiplier: 1
    property string fallback

    text: `${fallback ? fallback : getIcon()} ${(value * multiplier).toFixed(0)} %`
    color: "white"

    function getIcon() {
        const index = steps.findIndex((step) => value * multiplier < step);
        return index !== -1 ? icons[index] : icons[icons.length - 1];
    }

}