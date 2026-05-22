import QtQuick
import QtQuick.Shapes

Shape {
    id: shape
    preferredRendererType: Shape.CurveRenderer
    property int direction
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
        origin.x: shape.size * 0.5
        origin.y: shape.size * 0.5
        angle: shape.direction == Direction.SW ? 90 : 0
    }
}
