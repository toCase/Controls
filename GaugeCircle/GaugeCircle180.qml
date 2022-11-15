import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 430
    height: 230

    property int gc_step: 8
    property int gc_total: 1000
    property int gc_value: 0
    property bool gc_text: true
    property real _angle: 0
    property int gc_size: 135
    property int gc_duration: 750

    property color gc_color_ticks: "#3D4A71"
    property color gc_color_num: "#3D4A71"
    property color gc_color_value: "#3D4A71"
    property color gc_color_arrow: "#630630"
    property color gc_color_bg: "transparent"

    function make() {
        _angle = ((gc_size/gc_total) * gc_value)
        anim.running = true
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: gc_color_bg
        Canvas {
            id: canvaBase
            anchors.fill: parent
            renderStrategy: Canvas.Immediate
            onPaint: {
                var ctx = getContext("2d");

                ctx.translate(220, 220)
                ctx.strokeStyle = gc_color_ticks

                //--- small ticks ---
                ctx.beginPath()
                ctx.lineWidth = 1
                ctx.moveTo(-153, 0)
                ctx.lineTo(-150, 0)
                for (var a = 1; a < ((gc_step*5) + 1); a++){
                    ctx.save()
                    var radS = (gc_size / (gc_step * 5) * a) * Math.PI/180
                    ctx.rotate(radS)
                    ctx.moveTo(-153, 0)
                    ctx.lineTo(-150, 0)
                    ctx.restore()
                }
                ctx.stroke()

                //--- point ticks---
                ctx.beginPath()
                ctx.lineWidth = 3
                ctx.moveTo(-160, 0)
                ctx.lineTo(-150, 0)
                for (var i = 1; i < (gc_step + 1); i++){
                    ctx.save()
                    var radB = (gc_size / gc_step * i) * Math.PI/180
                    ctx.rotate(radB)
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
                ctx.reset
                ctx.translate(210, 220)
                ctx.fillStyle = gc_color_num
                ctx.font = 'normal 13pt Ubuntu'
                ctx.fillText("0", -180, 0)
                for (var i = 1; i < (gc_step + 1); i++){
                    var rad = (gc_size / gc_step * i) * Math.PI/180
                    var _x = 0 - 180 * Math.cos(rad)
                    var _y = 0 - 180 * Math.sin(rad)
                    ctx.font = 'normal 13pt Ubuntu'
                    ctx.fillText(gc_total / gc_step * i, _x, _y)
                }
                ctx.stroke()
            }
        }
        Rectangle {
            id: arrow
            width: 150
            height: 3
            radius: 5
            x: 70
            y: 220
            color: gc_color_arrow
            transformOrigin: Item.Right
            antialiasing: true
            PropertyAnimation {
                id: anim
                target: arrow
                properties: "rotation"
                to: _angle
                duration: gc_duration
               // easing: Easing.OutCirc
            }
        }
    }
    Label {
        id: valueText
        text: gc_value
        visible: gc_text
        x: 280
        y: 200
        width: 60
        color: gc_color_value
        font.pointSize: 18
        horizontalAlignment: Qt.AlignHCenter
    }
}
