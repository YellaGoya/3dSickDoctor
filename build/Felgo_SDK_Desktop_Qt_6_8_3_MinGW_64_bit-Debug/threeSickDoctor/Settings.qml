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

    // ✅ 전체 투명도 (페이드 인/아웃용)
    opacity: 0

    signal save

    Behavior on opacity {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    function openWindow() {
        settings.opacity = 0;
        popupContainer.scale = 0.95; // 열기 직전 껍데기를 작게 세팅

        settings.show();
        settings.raise();
        settings.requestActivate();

        settings.opacity = 1;
        popupContainer.scale = 1.0; // 뿅! 하고 원래 크기로 커짐
    }

    function closeWindow() {
        settings.opacity = 0;
        popupContainer.scale = 0.95; // 스르륵 작아지면서 사라짐
        closeTimer.start();
    }

    function showSaveSuccess() {
        toastText.text = "Saved successfully ✔️";
        toastMessage.border.color = "#d0d0d0";
        closeIcon.visible = false;

        toastMessage.opacity = 1;
        toastTimer.restart(); // 5초 타이머 시작 (중복 클릭 시 갱신)
    }

    function showSaveFailed() {
        toastText.text = "Failed to save ❌";
        toastMessage.border.color = "#d0d0d0";
        closeIcon.visible = false;

        toastMessage.opacity = 1;
        toastTimer.restart(); // 5초 타이머 시작
    }

    function showNeedSave() {
        toastText.text = "Need to save 👇";
        toastMessage.border.color = "#519cff"; // 파란색 테두리
        closeIcon.visible = true;              // X 버튼 노출

        toastMessage.opacity = 1;
        toastTimer.stop(); // 타이머를 강제로 꺼서 계속 떠있게 만듦
    }

    Timer {
        id: closeTimer
        interval: 250
        onTriggered: {
            // 위치 중앙 초기화
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

    // ✅ 그림자와 배경을 하나로 묶어주는 투명 껍데기!
    Item {
        id: popupContainer

        // 창 중앙 배치
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2

        width: 720
        height: 540

        // 스케일 기준점을 한가운데로 설정
        transformOrigin: Item.Center
        scale: 0.95

        // 껍데기 자체가 커지고 작아지는 애니메이션
        Behavior on scale {
            NumberAnimation {
                duration: 250
                easing.type: Easing.OutCubic
            }
        }

        // 1. 실제 배경
        Rectangle {
            id: background
            anchors.fill: parent // 껍데기에 꽉 채움
            radius: 16
            color: "#f9f9f9"
            border.color: "#e0e0e0"
            border.width: 1

            // 드래그 로직
            MouseArea {
                anchors.fill: parent
                onClicked: mouse.accepted = true
                onWheel: wheel.accepted = true

                // ✅ 이제 background가 아니라 popupContainer 전체를 끌고 다닙니다!
                drag.target: popupContainer
                drag.axis: Drag.XAndYAxis
            }

            RowLayout {
                anchors.fill: parent
                anchors.topMargin: 24
                anchors.bottomMargin: 24
                anchors.leftMargin: 24
                anchors.rightMargin: 24

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
                                color: "#fafafa"

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
                                color: "#20000000"
                            }

                            Text {
                                Layout.fillWidth: true
                                Layout.leftMargin: 10

                                text: "Settings"
                                color: "#101010"
                                font.family: sf.name // 참고: sf 폰트가 Main에 있다면 여기서 바로 못 찾을 수 있으니 안되면 font.family: "sf" 등으로 조정 필요
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
                                    color: "#fafafa"
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
                                    color: "#20000000"
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
                                    color: "#101010"
                                    opacity: 0.4
                                }

                                Text {
                                    id: menuText
                                    anchors.left: parent.left
                                    anchors.leftMargin: 20
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: modelData
                                    color: "#101010"
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
                                            color: "#fafafa"
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
                                            color: "#f0f0f0"
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
                                            duration: 150
                                            easing.type: Easing.OutCubic
                                        }
                                        ColorAnimation {
                                            duration: 250
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
                                color: "#2378ff"
                                font.family: sf.name
                                font.pixelSize: 16
                                font.weight: Font.Medium
                            }

                            MouseArea {
                                id: saveMouseArea
                                anchors.fill: parent
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
                                        color: "#202378ff"
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
                                    duration: 150
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
                                color: "#fafafa"
                                border.width: 1

                                opacity: 0

                                visible: opacity > 0

                                Behavior on opacity {
                                    NumberAnimation {
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
                                    id: toastText
                                    anchors.left: parent.left
                                    anchors.leftMargin: 12
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: "#101010"
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
                                        color: "#808080"
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
                    color: "#e0e0e0"
                }

                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Rectangle {
                        id: closeButton
                        anchors.top: parent.top
                        anchors.right: parent.right
                        width: closeText.implicitWidth + 20
                        height: 32
                        radius: 6
                        color: "transparent"

                        Text {
                            id: closeText
                            anchors.centerIn: parent
                            text: "Close"
                            color: "#2378ff"
                            font.family: sf.name
                            font.pixelSize: 16
                            font.weight: Font.Medium
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
                                    color: "#202378ff"
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
                                duration: 150
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

                        // ❌ 속성을 욱여넣던 불필요한 바인딩 코드가 모두 사라졌습니다!
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
            color: "#30000000"
        }
    }
}
