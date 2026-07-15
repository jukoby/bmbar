import QtQuick
import qs.base
import qs.components.update.data

BarButton {
    id: root
    text: ""
    tooltip: `󰌽${UpdateData.archUpdates}     ${UpdateData.flatpakUpdates}`
    visible: UpdateData.archUpdates + UpdateData.flatpakUpdates >= 10
    onLeftClicked: UpdateData.runUpdate()
}
