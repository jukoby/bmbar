import QtQuick

Loader {
    active: false
    visible: active
    
    required property var contentItem
    property int customHeight
    property bool rightSide: !leftSide
    property bool leftSide: !rightSide
    property bool maskEnabled: false
    property bool disableHeightAnimation: false

    function toggle() {
        active ? item.close = true : active = true
    }
}