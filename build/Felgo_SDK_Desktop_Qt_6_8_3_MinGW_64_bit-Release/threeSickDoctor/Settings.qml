import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Window {
    id: settings
    title: "3D Sick Doctor 설정"
    width: Screen.width
    height: Screen.height

    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent"

    property int menuIndex: 0
    property bool autoSave: false

    opacity: 0

    signal save

    Behavior on opacity {
        NumberAnimation {
            duration: Theme.animDuration
            easing.type: Easing.OutCubic
        }
    }

    function openWindow() {
        settings.opacity = 0;
        popupContainer.scale = 0.95;

        settings.show();
        settings.raise();
        settings.requestActivate();

        settings.opacity = 1;
        popupContainer.scale = 1.0;
    }

    function closeWindow() {
        settings.opacity = 0;
        popupContainer.scale = 0.95;
        closeTimer.start();
    }

    function showSaveSuccess() {
        toastText.text = "Saved successfully ✔️";
        toastMessage.border.color = Theme.border;
        closeIcon.visible = false;

        toastMessage.opacity = 1;
        toastTimer.restart();
    }

    function showSaveFailed() {
        toastText.text = "Failed to save ❌";
        toastMessage.border.color = Theme.border;
        closeIcon.visible = false;

        toastMessage.opacity = 1;
        toastTimer.restart();
    }

    function showNeedSave() {
        toastText.text = "Need to save 👇";
        toastMessage.border.color = Theme.accent;
        closeIcon.visible = true;

        toastMessage.opacity = 1;
        toastTimer.stop();
    }

    Timer {
        id: closeTimer
        interval: 250
        onTriggered: {
            popupContainer.x = (settings.width - popupContainer.width) / 2;
            popupContainer.y = (settings.height - popupContainer.height) / 2;
            settings.close();
        }
    }

    // 바깥 투명 영역 클릭 시 닫기
    MouseArea {
        anchors.fill: parent
        onClicked: settings.closeWindow()
    }

    Item {
        id: popupContainer

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        width: 720
        height: 540

        transformOrigin: Item.Center
        scale: 0.95

        Behavior on scale {
            NumberAnimation {
                duration: Theme.animDuration
                easing.type: Easing.OutCubic
            }
        }

        // 1. 실제 배경
        Rectangle {
            id: background
            anchors.fill: parent
            radius: 16
            color: Theme.background
            border.color: Theme.separator
            border.width: 1

            // 드래그 로직
            MouseArea {
                anchors.fill: parent
                onClicked: mouse.accepted = true
                onWheel: wheel.accepted = true

                drag.target: popupContainer
                drag.axis: Drag.XAndYAxis
            }

            RowLayout {
                anchors.fill: parent
                anchors.topMargin: 24
                anchors.bottomMargin: 24
                anchors.leftMargin: 24
                spacing: 24

                Item {
                    id: menuContainer
                    Layout.preferredWidth: 200
                    Layout.fillHeight: true

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        spacing: 10

                        RowLayout {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 32
                            Layout.leftMargin: -10
                            Layout.bottomMargin: 20
                            spacing: 0

                            Rectangle {
                                id: iconWrapper
                                Layout.preferredWidth: 32
                                Layout.preferredHeight: 32
                                radius: 8
                                color: Theme.surface

                                Image {
                                    source: "assets/Settings.png"
                                    sourceSize.width: 32
                                    sourceSize.height: 32
                                }
                            }

                            DropShadow {
                                anchors.fill: iconWrapper
                                source: iconWrapper

                                horizontalOffset: 0
                                verticalOffset: 4
                                radius: 16
                                samples: 33
                                color: Theme.shadowLight
                            }

                            Text {
                                Layout.fillWidth: true
                                Layout.leftMargin: 10

                                text: "Settings"
                                color: Theme.textPrimary
                                font.family: sf.name
                                font.weight: Font.Medium
                                font.pixelSize: 24
                            }
                        }

                        Repeater {
                            model: ["Dot", "Cross", "About"]

                            delegate: Item {
                                id: delegateItem
                                Layout.preferredHeight: 32
                                Layout.fillWidth: true

                                property bool isSelected: settings.menuIndex === index
                                property bool isHovered: mouseArea.containsMouse

                                state: isSelected ? "selected" : (isHovered ? "hovered" : "default")

                                Rectangle {
                                    id: menuBackground
                                    anchors.fill: parent
                                    radius: 8
                                    color: Theme.surface
                                    opacity: 0
                                }

                                DropShadow {
                                    id: dropShadow
                                    anchors.fill: menuBackground
                                    source: menuBackground
                                    horizontalOffset: 0
                                    verticalOffset: 4
                                    radius: 16
                                    samples: 33
                                    color: Theme.shadowLight
                                    opacity: 0
                                }

                                Rectangle {
                                    id: indicator
                                    anchors.left: parent.left
                                    anchors.leftMargin: 12
                                    anchors.verticalCenter: parent.verticalCenter
                                    height: 11
                                    width: 4
                                    radius: 2
                                    color: Theme.textPrimary
                                    opacity: 0.4
                                }

                                Text {
                                    id: menuText
                                    anchors.left: parent.left
                                    anchors.leftMargin: 20
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: modelData
                                    color: Theme.textPrimary
                                    font.family: sf.name
                                    font.pixelSize: 16
                                    font.weight: Font.Normal
                                    opacity: 0.6
                                }

                                MouseArea {
                                    id: mouseArea
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onClicked: {
                                        settings.menuIndex = index;
                                    }
                                }

                                states: [
                                    State {
                                        name: "selected"
                                        PropertyChanges {
                                            target: menuBackground
                                            opacity: 1
                                            color: Theme.surface
                                        }
                                        PropertyChanges {
                                            target: dropShadow
                                            opacity: 1
                                        }
                                        PropertyChanges {
                                            target: indicator
                                            opacity: 0.7
                                        }
                                        PropertyChanges {
                                            target: menuText
                                            opacity: 1
                                        }
                                    },
                                    State {
                                        name: "hovered"
                                        PropertyChanges {
                                            target: menuBackground
                                            opacity: 1
                                            color: Theme.backgroundHover
                                        }
                                        PropertyChanges {
                                            target: dropShadow
                                            opacity: 0
                                        }
                                        PropertyChanges {
                                            target: indicator
                                            opacity: 0.55
                                        }
                                        PropertyChanges {
                                            target: menuText
                                            opacity: 0.8
                                        }
                                    },
                                    State {
                                        name: "default"
                                        PropertyChanges {
                                            target: menuBackground
                                            opacity: 0
                                        }
                                        PropertyChanges {
                                            target: dropShadow
                                            opacity: 0
                                        }
                                        PropertyChanges {
                                            target: indicator
                                            opacity: 0.4
                                        }
                                        PropertyChanges {
                                            target: menuText
                                            opacity: 0.6
                                        }
                                    }
                                ]

                                transitions: [
                                    Transition {
                                        to: "selected"
                                        NumberAnimation {
                                            properties: "opacity"
                                            duration: Theme.animDurationFast
                                            easing.type: Easing.OutCubic
                                        }
                                        ColorAnimation {
                                            duration: Theme.animDuration
                                        }
                                    },
                                    Transition {
                                        from: "selected"
                                        NumberAnimation {
                                            properties: "opacity"
                                            duration: 0
                                        }
                                        ColorAnimation {
                                            duration: 0
                                        }
                                    },
                                    Transition {
                                        NumberAnimation {
                                            properties: "opacity"
                                            duration: 100
                                        }
                                        ColorAnimation {
                                            duration: 100
                                        }
                                    }
                                ]
                            }
                        }

                        Item {
                            Layout.preferredWidth: 1
                            Layout.fillHeight: true
                        }

                        Rectangle {
                            id: saveButton
                            Layout.fillWidth: true
                            Layout.leftMargin: -10
                            Layout.preferredHeight: 32
                            radius: 6
                            color: "transparent"

                            Text {
                                id: saveText
                                anchors.left: parent.left
                                anchors.leftMargin: 12
                                anchors.verticalCenter: parent.verticalCenter

                                text: "Save"
                                color: Theme.accentText
                                font.family: sf.name
                                font.pixelSize: 16
                                font.weight: Font.DemiBold
                            }

                            Text {
                                id: autoText
                                anchors.right: parent.right
                                anchors.rightMargin: 12
                                anchors.verticalCenter: parent.verticalCenter

                                text: "AUTO"
                                color: settings.autoSave ? Theme.accent : Theme.textTertiary
                                font.family: sf.name
                                font.pixelSize: 12
                                font.weight: Font.DemiBold

                                Behavior on color {
                                    ColorAnimation {
                                        duration: Theme.animDuration
                                        easing.type: Easing.OutCubic
                                    }
                                }

                                Rectangle {
                                    id: autoUnderline
                                    anchors.top: autoText.bottom
                                    anchors.topMargin: 1
                                    anchors.horizontalCenter: autoText.horizontalCenter
                                    width: autoText.width
                                    height: 2
                                    radius: 1
                                    color: Theme.accent
                                    opacity: settings.autoSave ? 1 : 0

                                    Behavior on opacity {
                                        NumberAnimation {
                                            duration: Theme.animDuration
                                            easing.type: Easing.OutCubic
                                        }
                                    }
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: settings.autoSave = !settings.autoSave
                                }
                            }

                            MouseArea {
                                id: saveMouseArea
                                anchors.left: parent.left
                                anchors.right: autoText.left
                                anchors.top: parent.top
                                anchors.bottom: parent.bottom
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: settings.save()
                            }

                            states: [
                                State {
                                    name: "hovered"
                                    when: saveMouseArea.containsMouse
                                    PropertyChanges {
                                        target: saveButton
                                        color: Theme.accentHover
                                    }
                                },
                                State {
                                    name: "default"
                                    when: !saveMouseArea.containsMouse
                                    PropertyChanges {
                                        target: saveButton
                                        color: "transparent"
                                    }
                                }
                            ]
                            transitions: Transition {
                                ColorAnimation {
                                    duration: Theme.animDurationFast
                                    easing.type: Easing.OutCubic
                                }
                            }

                            Rectangle {
                                id: toastMessage

                                anchors.left: saveButton.left
                                anchors.right: saveButton.right
                                anchors.bottom: saveButton.top
                                anchors.bottomMargin: 6

                                height: 32
                                radius: 6
                                color: Theme.surface
                                border.width: 1

                                opacity: 0

                                visible: opacity > 0

                                Behavior on opacity {
                                    NumberAnimation {
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
                                    id: toastText
                                    anchors.left: parent.left
                                    anchors.leftMargin: 12
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: Theme.textPrimary
                                    font.family: sf.name
                                    font.pixelSize: 14
                                    opacity: 0.7
                                }

                                MouseArea {
                                    id: closeIcon
                                    anchors.right: parent.right
                                    anchors.rightMargin: 8
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 20
                                    height: 20
                                    cursorShape: Qt.PointingHandCursor

                                    Text {
                                        anchors.centerIn: parent
                                        text: "✕"
                                        color: Theme.textTertiary
                                        font.pixelSize: 12
                                        font.weight: Font.Bold
                                    }

                                    onClicked: toastMessage.opacity = 0
                                }

                                Timer {
                                    id: toastTimer
                                    interval: 3000
                                    onTriggered: toastMessage.opacity = 0
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 1
                    Layout.fillHeight: true
                    color: Theme.separator
                }

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Rectangle {
                        id: closeButton
                        anchors.top: parent.top
                        anchors.right: parent.right
                        anchors.rightMargin: 24
                        width: closeText.implicitWidth + 20
                        height: 32
                        radius: 6
                        color: "transparent"

                        Text {
                            id: closeText
                            anchors.centerIn: parent
                            text: "Close"
                            color: Theme.accentText
                            font.family: sf.name
                            font.pixelSize: 16
                            font.weight: Font.DemiBold
                        }

                        MouseArea {
                            id: closeMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: settings.closeWindow()
                        }

                        states: [
                            State {
                                name: "hovered"
                                when: closeMouseArea.containsMouse
                                PropertyChanges {
                                    target: closeButton
                                    color: Theme.accentHover
                                }
                            },
                            State {
                                name: "default"
                                when: !closeMouseArea.containsMouse
                                PropertyChanges {
                                    target: closeButton
                                    color: "transparent"
                                }
                            }
                        ]
                        transitions: Transition {
                            ColorAnimation {
                                duration: Theme.animDurationFast
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    Loader {
                        id: contentLoader
                        anchors.fill: parent
                        sourceComponent: {
                            switch (settings.menuIndex) {
                            case 0:
                                return dotComponent;
                            case 1:
                                return crossComponent;
                            case 2:
                                return aboutComponent;
                            default:
                                return dotComponent;
                            }
                        }

                        Component {
                            id: dotComponent
                            DotContent {
                                anchors.fill: parent
                            }
                        }

                        Component {
                            id: crossComponent
                            CrossContent {
                                anchors.fill: parent
                            }
                        }

                        Component {
                            id: aboutComponent
                            AboutContent {
                                anchors.fill: parent
                            }
                        }
                    }
                }
            }
        }

        DropShadow {
            anchors.fill: background
            source: background
            horizontalOffset: 0
            verticalOffset: 4
            radius: 24
            samples: 49
            color: Theme.shadowMedium
        }
    }
}
