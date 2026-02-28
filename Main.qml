import QtQuick

// 파란 박스 윈도우 (입력 투과)
Window {
    id: boxWindow
    visible: true
    width: 200
    height: 200
    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.WindowTransparentForInput | Qt.Tool
    color: "transparent"
    title: qsTr("3D Sick Doctor Box")

    Rectangle {
        anchors.fill: parent
        color: "#3498db"
        radius: 10

        Text {
            anchors.centerIn: parent
            text: "3D 멀미 방지"
            color: "white"
            font.pixelSize: 16
            font.bold: true
        }
    }

    // 종료 버튼 윈도우 (클릭 가능)
    Window {
        id: closeButtonWindow
        visible: true
        width: 80
        height: 35
        x: Screen.width - width - 10
        y: 10
        flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool
        color: "transparent"
        title: qsTr("3D Sick Doctor Close")

        Rectangle {
            anchors.fill: parent
            color: closeMouseArea.containsMouse ? "#e74c3c" : "#c0392b"
            radius: 5

            Text {
                anchors.centerIn: parent
                text: "종료"
                color: "white"
                font.pixelSize: 14
            }

            MouseArea {
                id: closeMouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: Qt.quit()
            }
        }
    }
}

