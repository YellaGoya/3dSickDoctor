import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: settingsWindow
    title: "3D Sick Doctor 설정"
    width: 300
    height: 280
    flags: Qt.Window | Qt.WindowStaysOnTopHint
    modality: Qt.ApplicationModal
    color: "#2c3e50"

    // 설정 값 (외부에서 바인딩)
    property alias dotColor: colorPicker.selectedColor
    property alias dotOpacity: opacitySlider.value
    property alias spacing: spacingSpinBox.value
    property alias padding: paddingSpinBox.value

    signal settingsChanged()

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // 점 색상
        RowLayout {
            Layout.fillWidth: true
            Label { text: "점 색상"; color: "white"; Layout.preferredWidth: 80 }
            Rectangle {
                id: colorPicker
                property color selectedColor: "#98db80"
                width: 100
                height: 30
                color: selectedColor
                radius: 5
                border.color: "white"
                MouseArea {
                    anchors.fill: parent
                    onClicked: colorDialog.visible = true
                }
            }
        }

        // 점 불투명도
        RowLayout {
            Layout.fillWidth: true
            Label { text: "불투명도"; color: "white"; Layout.preferredWidth: 80 }
            Slider {
                id: opacitySlider
                from: 0.1
                to: 1.0
                value: 0.5
                stepSize: 0.1
                Layout.fillWidth: true
            }
            Label { text: opacitySlider.value.toFixed(1); color: "white"; Layout.preferredWidth: 30 }
        }

        // 간격
        RowLayout {
            Layout.fillWidth: true
            Label { text: "간격 (px)"; color: "white"; Layout.preferredWidth: 80 }
            SpinBox {
                id: spacingSpinBox
                from: 20
                to: 200
                value: 50
                stepSize: 10
                editable: true
            }
        }

        // 여백
        RowLayout {
            Layout.fillWidth: true
            Label { text: "여백 (px)"; color: "white"; Layout.preferredWidth: 80 }
            SpinBox {
                id: paddingSpinBox
                from: 0
                to: 200
                value: 50
                stepSize: 10
                editable: true
            }
        }

        // 버튼
        RowLayout {
            Layout.fillWidth: true
            Layout.topMargin: 10
            Button {
                text: "적용"
                Layout.fillWidth: true
                onClicked: {
                    settingsWindow.settingsChanged()
                    // settingsWindow.close()
                }
            }
            Button {
                text: "취소"
                Layout.fillWidth: true
                onClicked: settingsWindow.close()
            }
        }
    }

    // 색상 선택 다이얼로그
    Rectangle {
        id: colorDialog
        visible: false
        anchors.centerIn: parent
        width: 200
        height: 150
        color: "#34495e"
        radius: 10
        border.color: "white"

        Grid {
            anchors.centerIn: parent
            columns: 3
            spacing: 10

            Repeater {
                model: ["#98db80", "#3498db", "#e74c3c", "#f1c40f", "#9b59b6", "#1abc9c"]
                Rectangle {
                    width: 40
                    height: 40
                    radius: 5
                    color: modelData
                    border.color: colorPicker.selectedColor.toString() === modelData ? "white" : "transparent"
                    border.width: 2
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            colorPicker.selectedColor = modelData
                            colorDialog.visible = false
                        }
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: colorDialog.visible = false
        }
    }
}
