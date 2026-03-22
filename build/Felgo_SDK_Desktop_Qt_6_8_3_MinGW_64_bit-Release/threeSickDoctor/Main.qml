import QtQuick

// 점 격자 윈도우 (입력 투과)
Window {
    id: root
    visible: true
    width: Screen.width
    height: Screen.height
    x: 0
    y: 0
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.WindowTransparentForInput | Qt.Tool
    color: "transparent"
    title: qsTr("3D Sick Doctor")

    // FontLoader {
    //     id: sf
    //     source: "assets/Sf.ttf"
    // }

    // --- 단일 진실 공급원 (Single Source of Truth) ---
    // 모든 설정값은 오직 여기서만 관리됩니다.
    property bool isFirstTime: true
    property bool isLoadDone: false

    property bool dotEnabled: true
    property color dotColor: "#ffffff"
    property real dotOpacity: 0.5
    property int dotSize: 7
    property int dotSpacing: 50
    property int dotPadding: 50
    property bool dotCenterEnabled: true

    property bool crossEnabled: true
    property color crossColor: "#ffffff"
    property real crossOpacity: 0.5
    property int crossWeight: 30
    property int crossLength: 80
    property int crossInnerRadius: 8
    property int crossOuterRadius: 8
    property int crossVerticalPadding: 50
    property int crossHorizontalPadding: 50
    property bool crossCenterEnabled: true

    property int cols: Math.ceil((width - dotPadding * 2) / dotSpacing)
    property int rows: Math.ceil((height - dotPadding * 2) / dotSpacing)
    property real offsetX: dotPadding + (width - dotPadding * 2 - (cols - 1) * dotSpacing) / 2
    property real offsetY: dotPadding + (height - dotPadding * 2 - (rows - 1) * dotSpacing) / 2

    onDotEnabledChanged: handleConfigChanged()
    onDotColorChanged: handleConfigChanged()
    onDotOpacityChanged: handleConfigChanged()
    onDotSizeChanged: handleConfigChanged()
    onDotSpacingChanged: handleConfigChanged()
    onDotPaddingChanged: handleConfigChanged()
    onDotCenterEnabledChanged: handleConfigChanged()

    onCrossEnabledChanged: handleConfigChanged()
    onCrossColorChanged: handleConfigChanged()
    onCrossOpacityChanged: handleConfigChanged()
    onCrossWeightChanged: handleConfigChanged()
    onCrossLengthChanged: handleConfigChanged()
    onCrossInnerRadiusChanged: handleConfigChanged()
    onCrossOuterRadiusChanged: handleConfigChanged()
    onCrossVerticalPaddingChanged: handleConfigChanged()
    onCrossHorizontalPaddingChanged: handleConfigChanged()
    onCrossCenterEnabledChanged: handleConfigChanged()

    // --- 앱 시작 시 설정 파일 로드 ---
    Component.onCompleted: {
        var loadedData = configManager.load();

        // 헬퍼 함수: 숫자 범위를 안전하게 제한하는 클램프(Clamp) 함수
        function clamp(val, min, max, defaultVal) {
            var parsed = parseFloat(val);
            if (isNaN(parsed))
                return defaultVal;
            return Math.max(min, Math.min(max, parsed));
        }

        // 헬퍼 함수: 색상 코드가 유효한 16진수인지 검사 (#RRGGBB 또는 #AARRGGBB)
        function sanitizeColor(val, defaultVal) {
            if (typeof val !== 'string')
                return defaultVal;
            if (/^#[0-9A-Fa-f]{6}$/.test(val) || /^#[0-9A-Fa-f]{8}$/.test(val)) {
                return val;
            }
            return defaultVal;
        }

        // 헬퍼 함수: 불리언(Boolean) 값 검사
        function sanitizeBool(val, defaultVal) {
            if (typeof val === 'boolean')
                return val;
            if (val === 'true' || val === 1)
                return true;
            if (val === 'false' || val === 0)
                return false;
            return defaultVal;
        }

        if (loadedData && Object.keys(loadedData).length > 0) {
            if (loadedData.dot) {
                root.dotEnabled = sanitizeBool(loadedData.dot.enabled, root.dotEnabled);
                root.dotColor = sanitizeColor(loadedData.dot.color, root.dotColor);
                root.dotOpacity = clamp(loadedData.dot.opacity, 0.0, 1.0, root.dotOpacity);
                root.dotSize = Math.round(clamp(loadedData.dot.size, 0, 25, root.dotSize));
                root.dotSpacing = Math.round(clamp(loadedData.dot.spacing, 20, 200, root.dotSpacing));
                root.dotPadding = Math.round(clamp(loadedData.dot.padding, 0, 200, root.dotPadding));
                root.dotCenterEnabled = sanitizeBool(loadedData.dot.centerEnabled, root.dotCenterEnabled);
            }

            if (loadedData.cross) {
                root.crossEnabled = sanitizeBool(loadedData.cross.enabled, root.crossEnabled);
                root.crossColor = sanitizeColor(loadedData.cross.color, root.crossColor);
                root.crossOpacity = clamp(loadedData.cross.opacity, 0.0, 1.0, root.crossOpacity);
                root.crossWeight = Math.round(clamp(loadedData.cross.weight, 10, 200, root.crossWeight));
                root.crossLength = Math.round(clamp(loadedData.cross.length, 10, 200, root.crossLength));
                root.crossInnerRadius = Math.round(clamp(loadedData.cross.innerRadius, 0, 50, root.crossInnerRadius));
                root.crossOuterRadius = Math.round(clamp(loadedData.cross.outerRadius, 0, 50, root.crossOuterRadius));
                root.crossVerticalPadding = Math.round(clamp(loadedData.cross.verticalPadding, 0, 200, root.crossVerticalPadding));
                root.crossHorizontalPadding = Math.round(clamp(loadedData.cross.horizontalPadding, 0, 200, root.crossHorizontalPadding));
                root.crossCenterEnabled = sanitizeBool(loadedData.cross.centerEnabled, root.crossCenterEnabled);
            }

            root.isFirstTime = false;
        } else {
            root.isFirstTime = true;
        }

        root.isLoadDone = true;
    }

    function openSettings() {
        settingsWindow.openWindow();
    }

    function saveConfigurations() {
        var dataToSave = {
            dot: {
                enabled: root.dotEnabled,
                color: root.dotColor,
                opacity: root.dotOpacity,
                size: root.dotSize,
                spacing: root.dotSpacing,
                padding: root.dotPadding,
                centerEnabled: root.dotCenterEnabled
            },
            cross: {
                enabled: root.crossEnabled,
                color: root.crossColor,
                opacity: root.crossOpacity,
                weight: root.crossWeight,
                length: root.crossLength,
                innerRadius: root.crossInnerRadius,
                outerRadius: root.crossOuterRadius,
                verticalPadding: root.crossVerticalPadding,
                horizontalPadding: root.crossHorizontalPadding,
                centerEnabled: root.crossCenterEnabled
            }
        };

        var success = configManager.save(dataToSave);
        if (success) {
            settingsWindow.showSaveSuccess();
            root.isFirstTime = false;
        } else
            settingsWindow.showSaveFailed();
    }

    function handleConfigChanged() {
        if (!root.isLoadDone)
            return;

        if (root.isFirstTime)
            settingsWindow.showNeedSave();

        if (settingsWindow.autoSave)
            autoSaveTimer.restart();
    }

    Timer {
        id: autoSaveTimer
        interval: 150
        onTriggered: root.saveConfigurations()
    }

    // --- 도트 그리드 ---
    Repeater {
        model: root.cols * root.rows

        Item {
            property int col: index % root.cols
            property int row: Math.floor(index / root.cols)
            property bool isCenterDot: (col === Math.floor((root.cols - 1) / 2) || col === Math.ceil((root.cols - 1) / 2)) && (row === Math.floor((root.rows - 1) / 2) || row === Math.ceil((root.rows - 1) / 2))

            x: root.offsetX + col * root.dotSpacing
            y: root.offsetY + row * root.dotSpacing

            Rectangle {
                anchors.centerIn: parent
                visible: root.dotEnabled && (!parent.isCenterDot || root.dotCenterEnabled)
                width: root.dotSize
                height: root.dotSize
                radius: width / 2 + 1
                color: root.dotColor
                opacity: root.dotOpacity

                Behavior on width {
                    NumberAnimation {
                        duration: Theme.animDuration
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on height {
                    NumberAnimation {
                        duration: Theme.animDuration
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on color {
                    ColorAnimation {
                        duration: Theme.animDuration
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on opacity {
                    NumberAnimation {
                        duration: Theme.animDuration
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }

    // --- 상단 십자선 ---
    CrossArm {
        visible: root.crossEnabled
        anchors.top: parent.top
        anchors.topMargin: root.crossVerticalPadding
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.crossWeight
        height: root.crossLength
        topLeftRadius: root.crossOuterRadius
        topRightRadius: root.crossOuterRadius
        bottomLeftRadius: root.crossInnerRadius
        bottomRightRadius: root.crossInnerRadius
        color: root.crossColor
        opacity: root.crossOpacity
    }

    // --- 하단 십자선 ---
    CrossArm {
        visible: root.crossEnabled
        anchors.bottom: parent.bottom
        anchors.bottomMargin: root.crossVerticalPadding
        anchors.horizontalCenter: parent.horizontalCenter
        width: root.crossWeight
        height: root.crossLength
        topLeftRadius: root.crossInnerRadius
        topRightRadius: root.crossInnerRadius
        bottomLeftRadius: root.crossOuterRadius
        bottomRightRadius: root.crossOuterRadius
        color: root.crossColor
        opacity: root.crossOpacity
    }

    // --- 좌측 십자선 ---
    CrossArm {
        visible: root.crossEnabled
        anchors.left: parent.left
        anchors.leftMargin: root.crossHorizontalPadding
        anchors.verticalCenter: parent.verticalCenter
        width: root.crossLength
        height: root.crossWeight
        topLeftRadius: root.crossOuterRadius
        topRightRadius: root.crossInnerRadius
        bottomLeftRadius: root.crossOuterRadius
        bottomRightRadius: root.crossInnerRadius
        color: root.crossColor
        opacity: root.crossOpacity
    }

    // --- 우측 십자선 ---
    CrossArm {
        visible: root.crossEnabled
        anchors.right: parent.right
        anchors.rightMargin: root.crossHorizontalPadding
        anchors.verticalCenter: parent.verticalCenter
        width: root.crossLength
        height: root.crossWeight
        topLeftRadius: root.crossInnerRadius
        topRightRadius: root.crossOuterRadius
        bottomLeftRadius: root.crossInnerRadius
        bottomRightRadius: root.crossOuterRadius
        color: root.crossColor
        opacity: root.crossOpacity
    }

    // --- 중앙 십자선 컨테이너 ---
    Item {
        id: crossContainer
        visible: root.crossEnabled && root.crossCenterEnabled
        anchors.centerIn: parent

        property int centerWeight: Math.min(root.crossWeight, root.crossLength)
        property int centerLength: Math.max(root.crossWeight, root.crossLength)
        property real centerRadius: crossContainer.centerWeight == crossContainer.centerLength ? root.crossInnerRadius : Math.min(root.crossInnerRadius, (crossContainer.centerLength - crossContainer.centerWeight) / 2)

        width: crossContainer.centerLength
        height: crossContainer.centerLength
        opacity: root.crossOpacity
        layer.enabled: true

        Behavior on opacity {
            NumberAnimation {
                duration: Theme.animDuration
                easing.type: Easing.OutCubic
            }
        }

        // 중앙 세로 막대
        CrossArm {
            anchors.centerIn: parent
            width: parent.centerWeight
            height: parent.centerLength
            radius: parent.centerRadius
            color: root.crossColor
        }

        // 중앙 가로 막대
        CrossArm {
            anchors.centerIn: parent
            width: parent.centerLength
            height: parent.centerWeight
            radius: parent.centerRadius
            color: root.crossColor
        }
    }

    // 설정창
    Settings {
        id: settingsWindow
        onSave: root.saveConfigurations()
    }
}
