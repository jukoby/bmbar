import QtQuick
import QtQuick.Shapes

Shape {
    id: shape
    preferredRendererType: Shape.CurveRenderer
    property bool rightSide: !leftSide
    property bool leftSide: !rightSide
    required property int size

    ShapePath {
        id: shapePath
        strokeWidth: 0
        fillColor: '#111'
        
        PathAngleArc {
            moveToStart: false
            centerX: shape.size * (shape.rightSide ? -1 : 1)
            centerY: shape.size
            radiusX: shape.size * (shape.rightSide ? -1 : 1)
            radiusY: shape.size
            startAngle: 180
            sweepAngle: 90
        }
    }
}
