import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: dot

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Text {
            Layout.preferredHeight: 32
            Layout.bottomMargin: 20

            text: "Dots pattern configurations."
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

                // 점 활성화
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

                            color: root.dotEnabled ? Theme.accent : "transparent"
                            radius: 6
                            border.color: root.dotEnabled ? "transparent" : Theme.border
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
                                color: root.dotEnabled ? Theme.background : Theme.textSecondary
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
                                    root.dotEnabled = true;
                                }
                            }
                        }

                        Rectangle {
                            Layout.preferredHeight: 32
                            Layout.preferredWidth: 78

                            color: !root.dotEnabled ? Theme.accent : "transparent"
                            radius: 6
                            border.color: !root.dotEnabled ? "transparent" : Theme.border
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
                                color: !root.dotEnabled ? Theme.background : Theme.textSecondary
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
                                    root.dotEnabled = false;
                                }
                            }
                        }
                    }
                }

                // 중앙 점 활성화
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

                            color: root.dotCenterEnabled ? Theme.accent : "transparent"
                            radius: 6
                            border.color: root.dotCenterEnabled ? "transparent" : Theme.border
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
                                color: root.dotCenterEnabled ? Theme.background : Theme.textSecondary
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
                                    root.dotCenterEnabled = true;
                                }
                            }
                        }

                        Rectangle {
                            Layout.preferredHeight: 32
                            Layout.preferredWidth: 78

                            color: !root.dotCenterEnabled ? Theme.accent : "transparent"
                            radius: 6
                            border.color: !root.dotCenterEnabled ? "transparent" : Theme.border
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
                                color: !root.dotCenterEnabled ? Theme.background : Theme.textSecondary
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
                                    root.dotCenterEnabled = false;
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: colorInput

                        text: Theme.toHex(root.dotColor)

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

                                if (Theme.toHex(root.dotColor) !== upperText) {
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
                            color: Theme.textPrimary
                            opacity: 0.5
                        }
                    }

                    Rectangle {
                        id: colorPreview
                        width: 32
                        height: 32
                        radius: 6
                        color: root.dotColor.toString()
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
                        colorBar.syncColor(root.dotColor);
                    }

                    Connections {
                        target: root
                        function onDotColorChanged() {
                            colorBar.syncColor(root.dotColor);
                        }
                    }

                    onColorChangedByUser: function (newColor) {
                        root.dotColor = newColor.toString().toUpperCase();
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: opacityInput
                        text: Math.round(root.dotOpacity * 100).toString()
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
                                root.dotOpacity = opacityValue;
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

                // 점 크기
                RowLayout {
                    Layout.preferredHeight: 32
                    Layout.fillWidth: true

                    Label {
                        text: "Size"
                        font.pixelSize: 14
                        font.family: sf.name
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: sizeInput
                        text: root.dotSize.toString()
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
                            color: Theme.textPrimary
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: spacingInput
                        text: root.dotSpacing.toString()
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
                            color: Theme.textPrimary
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
                        color: Theme.textPrimary
                        Layout.fillWidth: true
                    }

                    TextField {
                        id: paddingInput
                        text: root.dotPadding.toString()
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
