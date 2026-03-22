import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: cross

    // ❌ 독자적으로 가지고 있던 property들 전부 삭제!
    // 이제 오직 Main.qml의 `root` 값만 바라봅니다.

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Text {
            Layout.preferredHeight: 32
            Layout.bottomMargin: 20

            text: "Cross pattern configurations."
            color: "#101010"
            font.pixelSize: 16
            font.family: sf.name
            font.weight: Font.Medium
            verticalAlignment: Text.AlignVCenter
            opacity: 0.7
        }

        // 크로스 활성화
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

                    color: root.crossEnabled ? '#519cff' : "transparent"
                    radius: 6
                    border.color: root.crossEnabled ? "transparent" : "#d0d0d0"
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
                        color: root.crossEnabled ? '#f9f9f9' : "#404040"
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
                            root.crossEnabled = true;
                        }
                    }
                }

                Rectangle {
                    Layout.preferredHeight: 32
                    Layout.preferredWidth: 78

                    color: !root.crossEnabled ? '#519cff' : "transparent"
                    radius: 6
                    border.color: !root.crossEnabled ? "transparent" : "#d0d0d0"
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
                        color: !root.crossEnabled ? '#f9f9f9' : "#404040"
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
                            root.crossEnabled = false;
                        }
                    }
                }
            }
        }

        // 크로스 색상
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
                    var hexStr = root.crossColor.toString();
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

                        var currentHex = root.crossColor.toString().length === 9 ? "#" + root.crossColor.toString().substring(3).toUpperCase() : root.crossColor.toString().toUpperCase();

                        if (currentHex !== upperText) {
                            root.crossColor = upperText;
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
                color: root.crossColor.toString()
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

        // 크로스 불투명도
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
                text: Math.round(root.crossOpacity * 100).toString()
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
                        root.crossOpacity = opacityValue; // 버그 수정: root.opacity -> root.crossOpacity
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
                    text: "0~1"
                    font.pixelSize: 14
                    font.family: sf.name
                    color: "#101010"
                    opacity: 0.5
                }
            }
        }

        // 크로스 두께 (Weight)
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true

            Label {
                text: "Weight"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            TextField {
                id: weightInput
                text: root.crossWeight.toString()
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
                        if (val >= 10 && val <= 200) {
                            root.crossWeight = val;
                        }
                    }
                }

                onEditingFinished: {
                    var val = parseInt(text, 10);
                    if (isNaN(val) || val < 10) {
                        text = "10";
                        root.crossWeight = 10;
                    }
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "10~200"
                    font.pixelSize: 14
                    font.family: sf.name
                    color: "#101010"
                    opacity: 0.5
                }
            }
        }

        // 크로스 길이
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true

            Label {
                text: "Length"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            TextField {
                id: lengthInput
                text: root.crossLength.toString()
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
                        if (val >= 10 && val <= 200) {
                            root.crossLength = val;
                        }
                    }
                }

                onEditingFinished: {
                    var val = parseInt(text, 10);
                    if (isNaN(val) || val < 10) {
                        text = "10";
                        root.crossLength = 10;
                    }
                }

                Text {
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "10~200"
                    font.pixelSize: 14
                    font.family: sf.name
                    color: "#101010"
                    opacity: 0.5
                }
            }
        }

        // 크로스 내부 둥글기
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true

            Label {
                text: "Inner radius"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            TextField {
                id: innerRadiusInput
                text: root.crossInnerRadius.toString()
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

                        if (val > 50) {
                            text = "50";
                            val = 50;
                        }

                        root.crossInnerRadius = val;
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
                    text: "0~50"
                    font.pixelSize: 14
                    font.family: sf.name
                    color: "#101010"
                    opacity: 0.5
                }
            }
        }

        // 크로스 외부 둥글기
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true

            Label {
                text: "Outer radius"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            TextField {
                id: outerRadiusInput
                text: root.crossOuterRadius.toString()
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

                        if (val > 50) {
                            text = "50";
                            val = 50;
                        }

                        root.crossOuterRadius = val;
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
                    text: "0~50"
                    font.pixelSize: 14
                    font.family: sf.name
                    color: "#101010"
                    opacity: 0.5
                }
            }
        }

        // 가로 여백
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true
            Layout.topMargin: 20

            Label {
                text: "Horizontal padding"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            TextField {
                id: horizontalPaddingInput
                text: root.crossHorizontalPadding.toString()
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

                        root.crossHorizontalPadding = val;
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

        // 세로 여백
        RowLayout {
            Layout.preferredHeight: 32
            Layout.fillWidth: true

            Label {
                text: "Vertical Padding"
                font.pixelSize: 14
                font.family: sf.name
                color: "#101010"
                Layout.fillWidth: true
            }

            TextField {
                id: verticalPaddingInput
                text: root.crossVerticalPadding.toString()
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

                        root.crossVerticalPadding = val;
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
