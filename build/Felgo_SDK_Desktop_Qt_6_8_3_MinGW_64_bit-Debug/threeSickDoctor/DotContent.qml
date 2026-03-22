import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: dot

    // ❌ 독자적으로 가지고 있던 property들과 onDotColorChanged 전부 삭제!
    // 이제 오직 Main.qml의 `root` 값만 바라봅니다.

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Text {
            Layout.preferredHeight: 32
            Layout.bottomMargin: 20

            text: "Dots pattern configurations."
            color: "#101010"
            font.pixelSize: 16
            font.family: sf.name
            font.weight: Font.Medium
            verticalAlignment: Text.AlignVCenter
            opacity: 0.7
        }

        // 점 활성화
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true
            spacing: 4

            Label {
                text: "Enabled"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            RowLayout {
                spacing: 4

                Rectangle {
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 78

                    color: root.dotEnabled ? '#519cff' : "transparent"
                    radius: 6
                    border.color: root.dotEnabled ? "transparent" : "#d0d0d0"
                    border.width: 1

                    Behavior on color {
                        ColorAnimation {
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on border.color {
                        ColorAnimation {
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "On"
                        color: root.dotEnabled ? '#f9f9f9' : "#404040"
                        font.pixelSize: 14
                        font.family: sf.name

                        Behavior on color {
                            ColorAnimation {
                                duration: 250
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.dotEnabled = true;
                        }
                    }
                }

                Rectangle {
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 78

                    color: !root.dotEnabled ? '#519cff' : "transparent"
                    radius: 6
                    border.color: !root.dotEnabled ? "transparent" : "#d0d0d0"
                    border.width: 1

                    Behavior on color {
                        ColorAnimation {
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on border.color {
                        ColorAnimation {
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "Off"
                        color: !root.dotEnabled ? '#f9f9f9' : "#404040"
                        font.pixelSize: 14
                        font.family: sf.name

                        Behavior on color {
                            ColorAnimation {
                                duration: 250
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.dotEnabled = false;
                        }
                    }
                }
            }
        }

        // 점 색상
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true
            Layout.topMargin: 20
            spacing: 4

            Label {
                text: "Color"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            TextField {
                id: colorInput

                // 수정 1: 처음부터 대문자로 변환해서 바인딩!
                // 이렇게 하면 초기 렌더링 시 onTextChanged에서 강제 할당이 일어나지 않아 바인딩이 끊어지지 않습니다.
                text: {
                    var hexStr = root.dotColor.toString();
                    var rgbStr = hexStr.length === 9 ? "#" + hexStr.substring(3) : hexStr;
                    return rgbStr.toUpperCase();
                }

                maximumLength: 7
                Layout.preferredHeight: 32
                Layout.preferredWidth: 124
                color: activeFocus ? "#101010" : "#404040"
                font.family: sf.name
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10

                background: Rectangle {
                    color: "transparent"
                    radius: 6
                    border.color: parent.activeFocus ? "#a0a0a0" : "#d0d0d0"
                }

                validator: RegularExpressionValidator {
                    regularExpression: /^[#0-9A-Fa-f]{0,7}$/
                }

                onTextChanged: {
                    if (text.length > 0 && text[0] !== '#') {
                        text = '#' + text.replace(/[^0-9A-Fa-f#]/g, '');
                    }
                    if (text.lastIndexOf('#') > 0) {
                        text = '#' + text.replace(/#/g, '');
                    }

                    if (text.match(/^#[0-9A-Fa-f]{6}$/)) {
                        var upperText = text.toUpperCase();

                        // 사용자가 소문자를 입력해 대문자로 강제 변환할 때만 실행
                        if (text !== upperText) {
                            var oldCursor = cursorPosition; // 커서 위치 저장
                            text = upperText;
                            cursorPosition = oldCursor; // 커서 위치 복구
                        }

                        var currentHex = root.dotColor.toString().length === 9 ? "#" + root.dotColor.toString().substring(3).toUpperCase() : root.dotColor.toString().toUpperCase();

                        if (currentHex !== upperText) {
                            root.dotColor = upperText;
                        }
                    }
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "hex"
                    font.pixelSize: 14
                    font.family: sf.name
                    color: "#101010"
                    opacity: 0.5
                }
            }

            Rectangle {
                id: colorPreview
                width: 32
                height: 32
                radius: 6
                color: root.dotColor.toString()
                border.color: "#d0d0d0"
                border.width: 1

                Behavior on color {
                    ColorAnimation {
                        duration: 250
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }

        // 점 불투명도
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true

            Label {
                text: "Opacity"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            TextField {
                id: opacityInput
                text: Math.round(root.dotOpacity * 100).toString()
                maximumLength: 3
                Layout.preferredHeight: 32
                Layout.preferredWidth: 160
                color: activeFocus ? "#101010" : "#404040"
                font.family: sf.name
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10

                background: Rectangle {
                    color: "transparent"
                    radius: 6
                    border.color: parent.activeFocus ? "#a0a0a0" : "#d0d0d0"
                }

                validator: RegularExpressionValidator {
                    regularExpression: /^[0-9]{0,3}$/
                }

                onTextChanged: {
                    var sanitized = text.replace(/[^0-9]/g, '');
                    if (text !== sanitized)
                        text = sanitized;

                    if (text.length > 0) {
                        var val = parseInt(text, 10);
                        if (val > 100) {
                            text = "100";
                            val = 100;
                        }

                        var opacityValue = val / 100.0;
                        root.dotOpacity = opacityValue; // 버그 수정: root.opacity -> root.dotOpacity
                    }
                }

                onEditingFinished: {
                    if (text === "")
                        text = "0";
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "0~100"
                    font.pixelSize: 14
                    font.family: sf.name
                    color: "#101010"
                    opacity: 0.5
                }
            }
        }

        // 점 크기
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true

            Label {
                text: "Size"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            TextField {
                id: sizeInput
                text: root.dotSize.toString()
                maximumLength: 3
                Layout.preferredHeight: 32
                Layout.preferredWidth: 160
                color: activeFocus ? "#101010" : "#404040"
                font.family: sf.name
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10

                background: Rectangle {
                    color: "transparent"
                    radius: 6
                    border.color: parent.activeFocus ? "#a0a0a0" : "#d0d0d0"
                }

                validator: RegularExpressionValidator {
                    regularExpression: /^[0-9]{0,3}$/
                }

                onTextChanged: {
                    var sanitized = text.replace(/[^0-9]/g, '');
                    if (text !== sanitized)
                        text = sanitized;

                    if (text.length > 0) {
                        var val = parseInt(text, 10);

                        if (val > 25) {
                            text = "25";
                            val = 25;
                        }

                        root.dotSize = val;
                    }
                }

                onEditingFinished: {
                    if (text === "")
                        text = "0";
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "0~25"
                    font.pixelSize: 14
                    font.family: sf.name
                    color: "#101010"
                    opacity: 0.5
                }
            }
        }

        // 간격
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true
            Layout.topMargin: 20

            Label {
                text: "Spacing"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            TextField {
                id: spacingInput
                text: root.dotSpacing.toString()
                maximumLength: 3
                Layout.preferredHeight: 32
                Layout.preferredWidth: 160
                color: activeFocus ? "#101010" : "#404040"
                font.family: sf.name
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10

                background: Rectangle {
                    color: "transparent"
                    radius: 6
                    border.color: parent.activeFocus ? "#a0a0a0" : "#d0d0d0"
                }

                validator: RegularExpressionValidator {
                    regularExpression: /^[0-9]{0,3}$/
                }

                onTextChanged: {
                    var sanitized = text.replace(/[^0-9]/g, '');
                    if (text !== sanitized)
                        text = sanitized;

                    if (text.length > 0) {
                        var val = parseInt(text, 10);
                        if (val > 200) {
                            text = "200";
                            val = 200;
                        }

                        if (val >= 20 && val <= 200) {
                            root.dotSpacing = val;
                        }
                    }
                }

                onEditingFinished: {
                    var val = parseInt(text, 10);
                    if (isNaN(val) || val < 20) {
                        text = "20";
                        root.dotSpacing = 20;
                    }
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "20~200"
                    font.pixelSize: 14
                    font.family: sf.name
                    color: "#101010"
                    opacity: 0.5
                }
            }
        }

        // 여백
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true

            Label {
                text: "Padding"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            TextField {
                id: paddingInput
                text: root.dotPadding.toString()
                maximumLength: 3
                Layout.preferredHeight: 32
                Layout.preferredWidth: 160
                color: activeFocus ? "#101010" : "#404040"
                font.family: sf.name
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
                leftPadding: 10

                background: Rectangle {
                    color: "transparent"
                    radius: 6
                    border.color: parent.activeFocus ? "#a0a0a0" : "#d0d0d0"
                }

                validator: RegularExpressionValidator {
                    regularExpression: /^[0-9]{0,3}$/
                }

                onTextChanged: {
                    var sanitized = text.replace(/[^0-9]/g, '');
                    if (text !== sanitized)
                        text = sanitized;

                    if (text.length > 0) {
                        var val = parseInt(text, 10);
                        if (val > 200) {
                            text = "200";
                            val = 200;
                        }

                        root.dotPadding = val;
                    }
                }

                onEditingFinished: {
                    if (text === "")
                        text = "0";
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "0~200"
                    font.pixelSize: 14
                    font.family: sf.name
                    color: "#101010"
                    opacity: 0.5
                }
            }
        }

        // 남은 하단 여백
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
