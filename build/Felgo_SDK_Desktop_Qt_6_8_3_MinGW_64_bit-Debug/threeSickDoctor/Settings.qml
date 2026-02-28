import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: settingsWindow
    title: "3D Sick Doctor 설정"
    width: 300
    height: 280
    minimumWidth: 300
    minimumHeight: 280
    maximumWidth: 300
    maximumHeight: 280
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    // modality: Qt.ApplicationModal
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        radius: 16
        color: "#2c3e50"
    }

    // 설정 값 (외부에서 바인딩)
    property color dotColor: "#98db80"
    property real dotOpacity: 0.5
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
            TextField {
                id: colorInput
                text: "#98db80"
                maximumLength: 7
                Layout.preferredWidth: 100
                color: "white"
                font.family: "monospace"
                horizontalAlignment: Text.AlignHCenter
                background: Rectangle {
                    color: "#34495e"
                    radius: 5
                    border.color: parent.activeFocus ? "white" : "#7f8c8d"
                }

                validator: RegularExpressionValidator {
                    regularExpression: /^[#0-9A-Fa-f]{0,7}$/
                }

                onTextChanged: {
                    // # 없이 입력 시작하면 자동 추가
                    if (text.length > 0 && text[0] !== '#') {
                        text = '#' + text.replace(/[^0-9A-Fa-f#]/g, '')
                    }
                    // #이 중간에 들어가면 제거
                    if (text.lastIndexOf('#') > 0) {
                        text = '#' + text.replace(/#/g, '')
                    }
                    // 유효한 색상이면 미리보기 업데이트
                    if (text.match(/^#[0-9A-Fa-f]{6}$/)) {
                        colorPreview.color = text
                    }
                }

                onAccepted: {
                    if (text.match(/^#[0-9A-Fa-f]{6}$/)) {
                        settingsWindow.dotColor = text
                    }
                }
            }
            Rectangle {
                id: colorPreview
                width: 30
                height: 30
                radius: 5
                color: "#98db80"
                border.color: "white"
            }
        }

        // 점 불투명도
        RowLayout {
            Layout.fillWidth: true
            Label { text: "불투명도"; color: "white"; Layout.preferredWidth: 80 }
            TextField {
                id: opacityInput
                text: "50"
                maximumLength: 3
                Layout.preferredWidth: 60
                color: "white"
                font.family: "monospace"
                horizontalAlignment: Text.AlignHCenter
                background: Rectangle {
                    color: "#34495e"
                    radius: 5
                    border.color: parent.activeFocus ? "white" : "#7f8c8d"
                }

                validator: IntValidator { bottom: 0; top: 100 }

                onTextChanged: {
                    // 숫자만 허용
                    text = text.replace(/[^0-9]/g, '')
                    // 범위 제한
                    if (text.length > 0 && parseInt(text) > 100) {
                        text = "100"
                    }
                }
            }
            Label { text: "%"; color: "white" }
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
                    // 색상 적용
                    if (colorInput.text.match(/^#[0-9A-Fa-f]{6}$/)) {
                        settingsWindow.dotColor = colorInput.text
                    }
                    // 불투명도 적용 (소수점 2자리)
                    var percent = parseInt(opacityInput.text) || 0
                    settingsWindow.dotOpacity = Math.round(percent) / 100
                    settingsWindow.settingsChanged()
                }
            }
            Button {
                text: "닫기"
                Layout.fillWidth: true
                onClicked: settingsWindow.close()
            }
        }
    }

    // 외부에서 색상 설정할 때 동기화
    onDotColorChanged: {
        colorInput.text = dotColor.toString().toUpperCase()
        colorPreview.color = dotColor
    }

    onDotOpacityChanged: {
        opacityInput.text = Math.round(dotOpacity * 100)
    }
}
