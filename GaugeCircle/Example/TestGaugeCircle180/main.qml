import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: app
    x: 250
    y: 250
    width: 425
    height: 235
    visible: true
    title: qsTr("GaugeCirle")

    function getRndInteger(min, max) {
      return Math.floor(Math.random() * (max - min + 1) ) + min;
    }

    GaugeCircle180 {
        id: gauge
        x:0
        y:0
        //anchors.fill: parent
        gc_total: 30
        gc_step: 10
        gc_text: true
        gc_size: 160
        gc_duration: 350
    }
    Timer {
        interval: 500;
        running: true;
        repeat: true
        onTriggered: {
            gauge.gc_value = getRndInteger(0, 30)
            gauge.make()
        }
    }
}
