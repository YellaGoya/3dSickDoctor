import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: cross

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Text {
            Layout.preferredHeight: 32
            Layout.bottomMargin: 20

            text: "Cross pattern configurations."
            color: Theme.textPrimary
            font.pixelSize: 16
            font.family: sf.name
            font.weight: Font.Medium
            verticalAlignment: Text.AlignVCenter
            opacity: 0.7
        }

        ScrollView {
            id: scrollView

            Layout.fillWidth: true
            Layout.fillHeight: true

            contentWidth: width
            clip: true

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout {
                width: scrollView.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 24
                spacing: 6

                RowLayout {
                    Layout.preferredHeight: 32
                    Layout.fillWidth: true
                    spacing: 4

                    Label {
                        text: "Enabled"
                        font.pixelSize: 14
                        font.family: sf.name
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    RowLayout {
                        spacing: 4

                        Rectangle {
                            Layout.preferredHeight: 32
                            Layout.preferredWidth: 78

                            color: root.crossEnabled ? Theme.accent : "transparent"
                            radius: 6
                            border.color: root.crossEnabled ? "transparent" : Theme.border
                            border.width: 1

                            Behavior on color {
                                ColorAnimation {
                                    duration: Theme.animDuration
                                    easing.type: Easing.OutCubic
                                }
                            }

                            Behavior on border.color {
                                ColorAnimation {
                                    duration: Theme.animDuration
                                    easing.type: Easing.OutCubic
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: "On"
                                color: root.crossEnabled ? Theme.background : Theme.textSecondary
                                font.pixelSize: 14
                                font.family: sf.name

                                Behavior on color {
                                    ColorAnimation {
                                        duration: Theme.animDuration
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

                            color: !root.crossEnabled ? Theme.accent : "transparent"
                            radius: 6
                            border.color: !root.crossEnabled ? "transparent" : Theme.border
                            border.width: 1

                            Behavior on color {
                                ColorAnimation {
                                    duration: Theme.animDuration
                                    easing.type: Easing.OutCubic
                                }
                            }

                            Behavior on border.color {
                                ColorAnimation {
                                    duration: Theme.animDuration
                                    easing.type: Easing.OutCubic
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: "Off"
                                color: !root.crossEnabled ? Theme.background : Theme.textSecondary
                                font.pixelSize: 14
                                font.family: sf.name

                                Behavior on color {
                                    ColorAnimation {
                                        duration: Theme.animDuration
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

                // 중앙 십자선 활성화
                RowLayout {
                    Layout.preferredHeight: 32
                    Layout.fillWidth: true
                    spacing: 4

                    Label {
                        text: "Center"
                        font.pixelSize: 14
                        font.family: sf.name
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    RowLayout {
                        spacing: 4

                        Rectangle {
                            Layout.preferredHeight: 32
                            Layout.preferredWidth: 78

                            color: root.crossCenterEnabled ? Theme.accent : "transparent"
                            radius: 6
                            border.color: root.crossCenterEnabled ? "transparent" : Theme.border
                            border.width: 1

                            Behavior on color {
                                ColorAnimation {
                                    duration: Theme.animDuration
                                    easing.type: Easing.OutCubic
                                }
                            }

                            Behavior on border.color {
                                ColorAnimation {
                                    duration: Theme.animDuration
                                    easing.type: Easing.OutCubic
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: "On"
                                color: root.crossCenterEnabled ? Theme.background : Theme.textSecondary
                                font.pixelSize: 14
                                font.family: sf.name

                                Behavior on color {
                                    ColorAnimation {
                                        duration: Theme.animDuration
                                        easing.type: Easing.OutCubic
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    root.crossCenterEnabled = true;
                                }
                            }
                        }

                        Rectangle {
                            Layout.preferredHeight: 32
                            Layout.preferredWidth: 78

                            color: !root.crossCenterEnabled ? Theme.accent : "transparent"
                            radius: 6
                            border.color: !root.crossCenterEnabled ? "transparent" : Theme.border
                            border.width: 1

                            Behavior on color {
                                ColorAnimation {
                                    duration: Theme.animDuration
                                    easing.type: Easing.OutCubic
                                }
                            }

                            Behavior on border.color {
                                ColorAnimation {
                                    duration: Theme.animDuration
                                    easing.type: Easing.OutCubic
                                }
                            }

                            Text {
                                anchors.centerIn: parent
                                text: "Off"
                                color: !root.crossCenterEnabled ? Theme.background : Theme.textSecondary
                                font.pixelSize: 14
                                font.family: sf.name

                                Behavior on color {
                                    ColorAnimation {
                                        duration: Theme.animDuration
                                        easing.type: Easing.OutCubic
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    root.crossCenterEnabled = false;
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: colorInput

                        text: Theme.toHex(root.crossColor)

                        maximumLength: 7
                        Layout.preferredHeight: 32
                        Layout.preferredWidth: 124
                        color: activeFocus ? Theme.textPrimary : Theme.textSecondary
                        font.family: sf.name
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10

                        background: Rectangle {
                            color: "transparent"
                            radius: 6
                            border.color: parent.activeFocus ? Theme.borderFocused : Theme.border
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

                                if (Theme.toHex(root.crossColor) !== upperText) {
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
                            color: Theme.textPrimary
                            opacity: 0.5
                        }
                    }

                    Rectangle {
                        id: colorPreview
                        width: 32
                        height: 32
                        radius: 6
                        color: root.crossColor.toString()
                        border.color: Theme.border
                        border.width: 1

                        Behavior on color {
                            ColorAnimation {
                                duration: Theme.animDuration
                                easing.type: Easing.OutCubic
                            }
                        }
                    }
                }

                ColorBar {
                    id: colorBar
                    Layout.fillWidth: true
                    Layout.preferredHeight: implicitHeight
                    Layout.topMargin: 10
                    Layout.bottomMargin: 10

                    Component.onCompleted: {
                        colorBar.syncColor(root.crossColor);
                    }

                    Connections {
                        target: root
                        function onCrossColorChanged() {
                            colorBar.syncColor(root.crossColor);
                        }
                    }

                    onColorChangedByUser: function (newColor) {
                        root.crossColor = newColor.toString().toUpperCase();
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: opacityInput
                        text: Math.round(root.crossOpacity * 100).toString()
                        maximumLength: 3
                        Layout.preferredHeight: 32
                        Layout.preferredWidth: 160
                        color: activeFocus ? Theme.textPrimary : Theme.textSecondary
                        font.family: sf.name
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10

                        background: Rectangle {
                            color: "transparent"
                            radius: 6
                            border.color: parent.activeFocus ? Theme.borderFocused : Theme.border
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
                                root.crossOpacity = opacityValue;
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
                            color: Theme.textPrimary
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: weightInput
                        text: root.crossWeight.toString()
                        maximumLength: 3
                        Layout.preferredHeight: 32
                        Layout.preferredWidth: 160
                        color: activeFocus ? Theme.textPrimary : Theme.textSecondary
                        font.family: sf.name
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10

                        background: Rectangle {
                            color: "transparent"
                            radius: 6
                            border.color: parent.activeFocus ? Theme.borderFocused : Theme.border
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
                            color: Theme.textPrimary
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: lengthInput
                        text: root.crossLength.toString()
                        maximumLength: 3
                        Layout.preferredHeight: 32
                        Layout.preferredWidth: 160
                        color: activeFocus ? Theme.textPrimary : Theme.textSecondary
                        font.family: sf.name
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10

                        background: Rectangle {
                            color: "transparent"
                            radius: 6
                            border.color: parent.activeFocus ? Theme.borderFocused : Theme.border
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
                            color: Theme.textPrimary
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: innerRadiusInput
                        text: root.crossInnerRadius.toString()
                        maximumLength: 3
                        Layout.preferredHeight: 32
                        Layout.preferredWidth: 160
                        color: activeFocus ? Theme.textPrimary : Theme.textSecondary
                        font.family: sf.name
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10

                        background: Rectangle {
                            color: "transparent"
                            radius: 6
                            border.color: parent.activeFocus ? Theme.borderFocused : Theme.border
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
                            color: Theme.textPrimary
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: outerRadiusInput
                        text: root.crossOuterRadius.toString()
                        maximumLength: 3
                        Layout.preferredHeight: 32
                        Layout.preferredWidth: 160
                        color: activeFocus ? Theme.textPrimary : Theme.textSecondary
                        font.family: sf.name
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10

                        background: Rectangle {
                            color: "transparent"
                            radius: 6
                            border.color: parent.activeFocus ? Theme.borderFocused : Theme.border
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
                            color: Theme.textPrimary
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: horizontalPaddingInput
                        text: root.crossHorizontalPadding.toString()
                        maximumLength: 3
                        Layout.preferredHeight: 32
                        Layout.preferredWidth: 160
                        color: activeFocus ? Theme.textPrimary : Theme.textSecondary
                        font.family: sf.name
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10

                        background: Rectangle {
                            color: "transparent"
                            radius: 6
                            border.color: parent.activeFocus ? Theme.borderFocused : Theme.border
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
                            color: Theme.textPrimary
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: verticalPaddingInput
                        text: root.crossVerticalPadding.toString()
                        maximumLength: 3
                        Layout.preferredHeight: 32
                        Layout.preferredWidth: 160
                        color: activeFocus ? Theme.textPrimary : Theme.textSecondary
                        font.family: sf.name
                        font.pixelSize: 14
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10

                        background: Rectangle {
                            color: "transparent"
                            radius: 6
                            border.color: parent.activeFocus ? Theme.borderFocused : Theme.border
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
                            color: Theme.textPrimary
                            opacity: 0.5
                        }
                    }
                }
            }
        }
    }

    Item {
        id: scrollTrack
        width: 16
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 52
        anchors.bottom: parent.bottom

        visible: scrollView.ScrollBar.vertical.size < 1.0

        Rectangle {
            id: fakeScrollbar
            width: 5
            radius: 2.5
            color: Theme.dark
            anchors.right: parent.right
            anchors.rightMargin: 7

            opacity: scrollMouseArea.containsMouse || scrollMouseArea.pressed ? 0.7 : 0.4
            Behavior on opacity {
                NumberAnimation {
                    duration: Theme.animDurationFast
                }
            }

            property real clampedSize: Math.max(0.01, Math.min(scrollView.ScrollBar.vertical.size, 1.0))
            property real clampedPosition: Math.max(0.0, Math.min(scrollView.ScrollBar.vertical.position, 1.0 - clampedSize))

            height: clampedSize * scrollTrack.height
            y: clampedPosition * scrollTrack.height
        }

        MouseArea {
            id: scrollMouseArea
            anchors.fill: parent
            hoverEnabled: true
            preventStealing: true

            property real dragStartY: 0
            property real startPos: 0

            onPressed: function (mouse) {
                if (mouse.y >= fakeScrollbar.y && mouse.y <= fakeScrollbar.y + fakeScrollbar.height) {
                    dragStartY = mouse.y;
                    startPos = fakeScrollbar.clampedPosition;
                } else {
                    var handleSizeRatio = fakeScrollbar.clampedSize;
                    var newPos = (mouse.y / scrollTrack.height) - (handleSizeRatio / 2);
                    newPos = Math.max(0.0, Math.min(newPos, 1.0 - handleSizeRatio));

                    scrollView.ScrollBar.vertical.position = newPos;

                    dragStartY = mouse.y;
                    startPos = newPos;
                }
            }

            onPositionChanged: function (mouse) {
                if (pressed) {
                    var deltaY = mouse.y - dragStartY;
                    var deltaPos = deltaY / scrollTrack.height;
                    var newPos = startPos + deltaPos;

                    var maxPos = 1.0 - fakeScrollbar.clampedSize;
                    newPos = Math.max(0.0, Math.min(newPos, maxPos));

                    scrollView.ScrollBar.vertical.position = newPos;
                }
            }
        }
    }
}
