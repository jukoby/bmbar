import QtQuick
import qs.base
import qs.components.update.data

BarButton {
    id: root
    text: ""
    tooltip: `󰌽${UpdateData.linuxUpdates}     ${UpdateData.flatpakUpdates}`
    visible: UpdateData.linuxUpdates + UpdateData.flatpakUpdates >= 10
    onLeftClicked: UpdateData.runUpdate()
}
