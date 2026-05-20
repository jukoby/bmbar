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
            centerX: shape.size
            centerY: shape.size
            radiusX: shape.size
            radiusY: shape.size
            startAngle: 180
            sweepAngle: 90
        }
    }

    transform: Rotation {
        origin.x: size * 0.5
        origin.y: size * 0.5
        angle: rightSide ? 90 : 0
    }
}
