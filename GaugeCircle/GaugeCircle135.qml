import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 420
    height: 230

    property int _step: 8
    property int _total: 2000
    property int _value: 0
    property bool _textVisible: true
    property real _angle: 0
    property color _color_ticks: "#3A8782"
    property color _color_arrow: "#7A0000"

    function make() {
        _angle = ((135/_total) * _value)
        anim.running = true
    }

    Canvas {
        id: canvaBase
        anchors.fill: parent
        renderStrategy: Canvas.Immediate
        onPaint: {
            var ctx = getContext("2d");

            ctx.translate(220, 220)
            ctx.strokeStyle = _color_ticks

            //--- small ---
            ctx.beginPath()
            ctx.lineWidth = 1
            //ctx.arc(0,0,2,0,Math.PI*2,true);

            ctx.moveTo(-153, 0)
            ctx.lineTo(-150, 0)

            for (var a = 1; a < ((_step*5) + 1); a++){
                ctx.save()
                var rad = (135 / (_step * 5) * a) * Math.PI/180

                ctx.rotate(rad)
                ctx.moveTo(-153, 0)
                ctx.lineTo(-150, 0)

                ctx.restore()
            }
            ctx.stroke()

            //--- point ---
            ctx.beginPath()
            ctx.lineWidth = 3
            //ctx.arc(0,0,2,0,Math.PI*2,true);

            ctx.moveTo(-160, 0)
            ctx.lineTo(-150, 0)

            for (var i = 1; i < (_step + 1); i++){
                ctx.save()
                var deg = (135 / _step * i) * Math.PI/180

                ctx.rotate(deg)
                ctx.moveTo(-160, 0)
                ctx.lineTo(-150, 0)

                ctx.restore()
            }
            ctx.stroke()
        }
    }
    Canvas {
        id: canvaNum
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");

            ctx.translate(210, 220)

            ctx.fillStyle = _color_ticks
            ctx.font = 'normal 13pt Ubuntu'
            ctx.fillText("0", -180, 0)

            for (var i = 1; i < (_step + 1); i++){
                var deg = (135 / _step * i) * Math.PI/180

                var _x = 0 - 180 * Math.cos(deg)
                var _y = 0 - 180 * Math.sin(deg)

                ctx.font = 'normal 13pt Ubuntu'
                ctx.fillText(_total / _step * i, _x, _y)
            }

            ctx.stroke()
        }
    }
    Rectangle {
        id: background
        anchors.fill: parent
        color: "transparent"

        Rectangle {
            id: arrow
            width: 150
            height: 3
            radius: 5
            x: 70
            y: 219
            color: _color_arrow
            transformOrigin: Item.Right
            antialiasing: true

            PropertyAnimation {
                id: anim
                target: arrow
                properties: "rotation"
                to: _angle
                duration: 450
               // easing: Easing.OutCirc
            }

        }
    }
    Label {
        id: valueText
        text: _value
        visible: _textVisible
        x: 280
        y: 200
        width: 60
        color: _color_ticks
        font.pointSize: 18
        horizontalAlignment: Qt.AlignHCenter
    }
}
