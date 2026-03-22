import QtQuick
import QtQuick.Controls

Item {
    id: control

    implicitWidth: 200
    implicitHeight: (24 * 3) + (18 * 2) + 12

    property real hue: 0.0
    property real saturation: 1.0
    property real brightness: 1.0

    property real handlePadding: 12

    readonly property color selectedColor: Qt.hsva(hue, saturation, brightness, 1.0)

    // 여백 계산용 공통 프로퍼티
    readonly property real _p0: handlePadding / Math.max(width, 1)
    readonly property real _pRange: Math.max((width - handlePadding * 2) / Math.max(width, 1), 0.001)

    // ==========================================
    // ✨ [추가] 양방향 동기화 로직
    // ==========================================

    // 사용자가 마우스로 슬라이더를 조작 중인지 확인하는 플래그
    property bool isInteracting: hueMouseArea.pressed || satMouseArea.pressed || briMouseArea.pressed

    // 슬라이더를 조작했을 때 밖(Main.qml)으로 색상값을 보내는 시그널
    signal colorChangedByUser(color newColor)

    // 내부 HSV 값이 바뀌어 selectedColor가 변할 때, "사용자가 직접 조작 중"일 때만 시그널 발송
    onSelectedColorChanged: {
        if (isInteracting) {
            colorChangedByUser(selectedColor);
        }
    }

    // 클릭(press+release)만 했을 때도 색상 확정
    property bool _pendingClick: false
    onIsInteractingChanged: {
        if (isInteracting) {
            _pendingClick = true;
        } else if (_pendingClick) {
            _pendingClick = false;
            colorChangedByUser(selectedColor);
        }
    }

    // 외부(텍스트 필드 등)에서 값이 변경되었을 때 슬라이더의 HSV 값을 업데이트하는 함수
    function syncColor(hexString) {
        if (isInteracting) return; // 내가 드래그 중일 때는 외부 간섭 무시

        var c = Qt.color(hexString);
        var h = c.hsvHue;
        var s = c.hsvSaturation;
        var v = c.hsvValue;

        // 완전 흰색, 검은색일 경우 Hue 값이 유실(-1 등)되므로, 기존 Hue 값을 보호하여 슬라이더가 튕기는 현상 방지
        if (s > 0.001 && h >= 0.0) {
            hue = h;
        }
        saturation = s;
        brightness = v;
    }

    // ==========================================

    Column {
        anchors.fill: parent
        spacing: 18

        // ==========================================
        // 1. Hue (색상) 슬라이더
        // ==========================================
        Item {
            width: parent.width
            height: 24

            Rectangle {
                anchors.fill: parent
                radius: 8
                border.color: Theme.border
                border.width: 1

                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#FF0000" }
                    GradientStop { position: control._p0; color: "#FF0000" }
                    GradientStop { position: control._p0 + 0.166 * control._pRange; color: "#FFFF00" }
                    GradientStop { position: control._p0 + 0.333 * control._pRange; color: "#00FF00" }
                    GradientStop { position: control._p0 + 0.500 * control._pRange; color: "#00FFFF" }
                    GradientStop { position: control._p0 + 0.666 * control._pRange; color: "#0000FF" }
                    GradientStop { position: control._p0 + 0.833 * control._pRange; color: "#FF00FF" }
                    GradientStop { position: control._p0 + 1.000 * control._pRange; color: "#FF0000" }
                    GradientStop { position: 1.0; color: "#FF0000" }
                }
            }

            MouseArea {
                id: hueMouseArea
                anchors.fill: parent
                function updateValue(mouse) {
                    var activeWidth = width - (control.handlePadding * 2);
                    var val = (mouse.x - control.handlePadding) / activeWidth;
                    control.hue = Math.max(0.0, Math.min(1.0, val));
                }
                onPressed: function(mouse) { updateValue(mouse) }
                onPositionChanged: function(mouse) { updateValue(mouse) }
            }

            Canvas {
                width: 12
                height: 10
                y: parent.height + 2
                x: control.handlePadding + (control.hue * (parent.width - control.handlePadding * 2)) - (width / 2)

                scale: hueMouseArea.pressed ? 1.2 : 1.0
                Behavior on scale { NumberAnimation { duration: 100 } }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height); // 이전 프레임 잔상 지우기
                    ctx.lineJoin = "round";
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "#303030";
                    ctx.fillStyle = "#303030";

                    ctx.beginPath();
                    // 경계선에 닿지 않도록 안쪽(2px)으로 여유를 두고 삼각형을 그림
                    ctx.moveTo(width / 2, 2);
                    ctx.lineTo(width - 2, height - 2);
                    ctx.lineTo(2, height - 2);
                    ctx.closePath();
                    ctx.fill();
                    ctx.stroke();
                }
            }
        }

        // ==========================================
        // 2. Saturation (채도) 슬라이더
        // ==========================================
        Item {
            width: parent.width
            height: 24

            Rectangle {
                anchors.fill: parent
                radius: 8
                border.color: Theme.border
                border.width: 1

                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: Qt.hsva(control.hue, 0.0, control.brightness, 1.0) }
                    GradientStop { position: control._p0; color: Qt.hsva(control.hue, 0.0, control.brightness, 1.0) }
                    GradientStop { position: control._p0 + control._pRange; color: Qt.hsva(control.hue, 1.0, control.brightness, 1.0) }
                    GradientStop { position: 1.0; color: Qt.hsva(control.hue, 1.0, control.brightness, 1.0) }
                }
            }

            MouseArea {
                id: satMouseArea
                anchors.fill: parent
                function updateValue(mouse) {
                    var activeWidth = width - (control.handlePadding * 2);
                    var val = (mouse.x - control.handlePadding) / activeWidth;
                    control.saturation = Math.max(0.0, Math.min(1.0, val));
                }
                onPressed: function(mouse) { updateValue(mouse) }
                onPositionChanged: function(mouse) { updateValue(mouse) }
            }

            Canvas {
                width: 12
                height: 10
                y: parent.height + 2
                x: control.handlePadding + (control.saturation * (parent.width - control.handlePadding * 2)) - (width / 2)

                scale: satMouseArea.pressed ? 1.2 : 1.0
                Behavior on scale { NumberAnimation { duration: 100 } }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);
                    ctx.lineJoin = "round";
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "#303030";
                    ctx.fillStyle = "#303030";

                    ctx.beginPath();
                    ctx.moveTo(width / 2, 2);
                    ctx.lineTo(width - 2, height - 2);
                    ctx.lineTo(2, height - 2);
                    ctx.closePath();
                    ctx.fill();
                    ctx.stroke();
                }
            }
        }

        // ==========================================
        // 3. Brightness (밝기) 슬라이더
        // ==========================================
        Item {
            width: parent.width
            height: 24

            Rectangle {
                anchors.fill: parent
                radius: 8
                border.color: Theme.border
                border.width: 1

                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: Qt.hsva(control.hue, control.saturation, 0.0, 1.0) }
                    GradientStop { position: control._p0; color: Qt.hsva(control.hue, control.saturation, 0.0, 1.0) }
                    GradientStop { position: control._p0 + control._pRange; color: Qt.hsva(control.hue, control.saturation, 1.0, 1.0) }
                    GradientStop { position: 1.0; color: Qt.hsva(control.hue, control.saturation, 1.0, 1.0) }
                }
            }

            MouseArea {
                id: briMouseArea
                anchors.fill: parent
                function updateValue(mouse) {
                    var activeWidth = width - (control.handlePadding * 2);
                    var val = (mouse.x - control.handlePadding) / activeWidth;
                    control.brightness = Math.max(0.0, Math.min(1.0, val));
                }
                onPressed: function(mouse) { updateValue(mouse) }
                onPositionChanged: function(mouse) { updateValue(mouse) }
            }

            Canvas {
                width: 12
                height: 10
                y: parent.height + 2
                x: control.handlePadding + (control.brightness * (parent.width - control.handlePadding * 2)) - (width / 2)

                scale: briMouseArea.pressed ? 1.2 : 1.0
                Behavior on scale { NumberAnimation { duration: 100 } }

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.clearRect(0, 0, width, height);
                    ctx.lineJoin = "round";
                    ctx.lineWidth = 2;
                    ctx.strokeStyle = "#303030";
                    ctx.fillStyle = "#303030";

                    ctx.beginPath();
                    ctx.moveTo(width / 2, 2);
                    ctx.lineTo(width - 2, height - 2);
                    ctx.lineTo(2, height - 2);
                    ctx.closePath();
                    ctx.fill();
                    ctx.stroke();
                }
            }
        }
    }
}
