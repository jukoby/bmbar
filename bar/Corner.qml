import QtQuick
import QtQuick.Shapes


Shape {
    id: shape

    required property bool rightSide
    property int screenSize
    preferredRendererType: Shape.CurveRenderer
    x: rightSide ? screenSize : 0
    y: 30

    ShapePath {
        id: shapePath
        strokeWidth: 0
        fillColor: '#111'

        startX: 0
        startY: 0
        
        PathAngleArc {
            moveToStart: false
            centerX: shape.rightSide ? -20 : 20
            centerY: 20
            radiusX: shape.rightSide ? -20 : 20
            radiusY: 20
            startAngle: 180
            sweepAngle: 90
        }
    }
}
