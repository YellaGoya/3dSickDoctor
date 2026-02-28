import QtQuick

// 점 격자 윈도우 (입력 투과)
Window {
    id: boxWindow
    visible: true
    width: Screen.width
    height: Screen.height
    x: 0
    y: 0
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.WindowTransparentForInput
    color: "transparent"
    title: qsTr("3D Sick Doctor")

    property int dotSize: 7
    property int spacing: 50
    property int padding: 50
    property real dotOpacity: 0.5

    property int cols: Math.ceil((width - padding * 2) / spacing)
    property int rows: Math.ceil((height - padding * 2) / spacing)
    property real offsetX: padding + (width - padding * 2 - (cols - 1) * spacing) / 2
    property real offsetY: padding + (height - padding * 2 - (rows - 1) * spacing) / 2

    Repeater {
        model: boxWindow.cols * boxWindow.rows
        Rectangle {
            width: boxWindow.dotSize
            height: boxWindow.dotSize
            radius: boxWindow.dotSize / 2 + 1
            color: "#98db80"
            opacity: boxWindow.dotOpacity
            x: boxWindow.offsetX + (index % boxWindow.cols) * boxWindow.spacing - boxWindow.dotSize / 2
            y: boxWindow.offsetY + Math.floor(index / boxWindow.cols) * boxWindow.spacing - boxWindow.dotSize / 2
        }
    }
}
