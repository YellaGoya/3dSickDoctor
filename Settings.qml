import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Window {
    id: root
    title: "3D Sick Doctor 설정"
    width: 800
    height: 620
    minimumWidth: 800
    minimumHeight: 620
    maximumWidth: 800
    maximumHeight: 620
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent"

    property color dotColor: "#98db80"
    property real dotOpacity: 0.5
    property alias spacing: spacingSpinBox.value
    property alias padding: paddingSpinBox.value

    property int menuIndex: 0

    signal settingsChanged()

    Rectangle {
        id: background
        anchors.centerIn: parent
        width: 720
        height: 540

        radius: 16
        color: "#f9f9f9"

        border.color: "#e0e0e0"
        border.width: 1

        RowLayout {
            anchors.fill: parent;
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
                        Layout.bottomMargin: 10
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
                            samples: 33           // 공식 권장값: radius * 2 + 1
                            color: "#20000000"    // 핵심! 완전한 검은색이 아닌 반투명한 검은색을 써야 합니다.
                        }

                        Text {
                            Layout.fillWidth: true
                            Layout.leftMargin: 10

                            text: "Settings"
                            color: "#101010"
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

                            // 1. 현재 아이템의 상태를 판단하기 위한 속성
                            property bool isSelected: root.menuIndex === index
                            property bool isHovered: mouseArea.containsMouse

                            // 2. 상태 결정 (선택됨 > 마우스 오버 > 기본)
                            state: isSelected ? "selected" : (isHovered ? "hovered" : "default")

                            Rectangle {
                                id: menuBackground
                                anchors.fill: parent
                                radius: 8
                                color: "#fafafa"
                                opacity: 0 // 기본값 (states에서 제어됨)
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
                                    root.menuIndex = index;
                                }
                            }

                            states: [
                                State {
                                    name: "selected" // 클릭되어 선택된 상태
                                    PropertyChanges { target: menuBackground; opacity: 1; color: "#fafafa" }
                                    PropertyChanges { target: dropShadow; opacity: 1 }
                                    PropertyChanges { target: indicator; opacity: 0.7 }
                                    PropertyChanges { target: menuText; opacity: 1 }
                                },
                                State {
                                    name: "hovered" // 마우스만 올려진 상태
                                    PropertyChanges { target: menuBackground; opacity: 1; color: "#f0f0f0" } // 살짝 진한 배경
                                    PropertyChanges { target: dropShadow; opacity: 0 } // 그림자는 숨김
                                    PropertyChanges { target: indicator; opacity: 0.55 } // 살짝 밝아짐
                                    PropertyChanges { target: menuText; opacity: 0.8 }   // 글씨 살짝 진해짐
                                },
                                State {
                                    name: "default" // 기본 상태
                                    PropertyChanges { target: menuBackground; opacity: 0 }
                                    PropertyChanges { target: dropShadow; opacity: 0 }
                                    PropertyChanges { target: indicator; opacity: 0.4 }
                                    PropertyChanges { target: menuText; opacity: 0.6 }
                                }
                            ]

                            // --- 4. 전환 애니메이션(Transitions) 정의 ---
                            transitions: [
                                Transition {
                                    to: "selected" // 선택될 때 (켜질 때 부드럽게)
                                    NumberAnimation { properties: "opacity"; duration: 150; easing.type: Easing.OutCubic }
                                    ColorAnimation { duration: 250 }
                                },
                                Transition {
                                    from: "selected" // 선택 해제될 때 (잔상 없이 즉시 꺼짐!)
                                    NumberAnimation { properties: "opacity"; duration: 0 }
                                    ColorAnimation { duration: 0 }
                                },
                                Transition {
                                    // Hover 되거나 Hover가 풀릴 때의 부드러운 전환
                                    NumberAnimation { properties: "opacity"; duration: 100 }
                                    ColorAnimation { duration: 100 }
                                }
                            ]
                        }
                    }

                    Item {
                        Layout.preferredWidth: 1
                        Layout.fillHeight: true
                    }
                }
            }

            Rectangle {
                Layout.preferredWidth: 1
                Layout.fillHeight: true

                color: "#e0e0e0"
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 15

                // 상단 버튼 영역
                RowLayout {
                    Layout.preferredHeight: 32 // 높이 고정
                    Layout.fillWidth: true
                    spacing: 10

                    // --- Apply 버튼 ---
                    Rectangle {
                        id: applyButton
                        Layout.preferredWidth: applyText.implicitWidth + 20
                        Layout.preferredHeight: 32 // 💡 fillHeight 대신 높이를 명시하여 늘어남 방지!
                        Layout.leftMargin: -10
                        radius: 6 // 버튼을 살짝 둥글게
                        color: "transparent" // 기본 배경은 투명

                        Text {
                            id: applyText
                            anchors.centerIn: parent
                            text: "Apply"
                            color: "#2378ff"
                            font.family: sf.name
                            font.pixelSize: 16
                            font.weight: Font.Normal
                        }

                        MouseArea {
                            id: applyMouseArea
                            anchors.fill: parent
                            hoverEnabled: true // Hover 활성화
                            cursorShape: Qt.PointingHandCursor // 마우스 올리면 손가락 커서로 변경
                            onClicked: {
                                if (colorInput.text.match(/^#[0-9A-Fa-f]{6}$/)) {
                                    settingsWindow.dotColor = colorInput.text
                                }

                                var percent = parseInt(opacityInput.text) || 0
                                root.dotOpacity = Math.round(percent) / 100
                                root.settingsChanged()
                            }
                        }

                        // Hover 상태와 애니메이션 적용
                        states: [
                            State {
                                name: "hovered"; when: applyMouseArea.containsMouse
                                PropertyChanges { target: applyButton; color: "#202378ff" } // 마우스 오버 시 연한 파란색 배경
                            },
                            State {
                                name: "default"; when: !applyMouseArea.containsMouse
                                PropertyChanges { target: applyButton; color: "transparent" }
                            }
                        ]
                        transitions: Transition {
                            ColorAnimation { duration: 150; easing.type: Easing.OutCubic }
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 1
                    }

                    // --- Close 버튼 ---
                    Rectangle {
                        id: closeButton
                        Layout.preferredWidth: closeText.implicitWidth + 20
                        Layout.preferredHeight: 32 // 💡 여기도 늘어남 방지
                        radius: 6
                        color: "transparent"

                        Text {
                            id: closeText
                            anchors.centerIn: parent
                            text: "Close"
                            color: "#2378ff"
                            font.family: sf.name
                            font.pixelSize: 16
                            font.weight: Font.Normal
                        }

                        MouseArea {
                            id: closeMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.close()
                        }

                        states: [
                            State {
                                name: "hovered"; when: closeMouseArea.containsMouse
                                PropertyChanges { target: closeButton; color: "#202378ff" } // 동일한 Hover 효과
                            },
                            State {
                                name: "default"; when: !closeMouseArea.containsMouse
                                PropertyChanges { target: closeButton; color: "transparent" }
                            }
                        ]
                        transitions: Transition {
                            ColorAnimation { duration: 150; easing.type: Easing.OutCubic }
                        }
                    }
                }

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
                            if (text.length > 0 && text[0] !== '#') {
                                text = '#' + text.replace(/[^0-9A-Fa-f#]/g, '')
                            }
                            if (text.lastIndexOf('#') > 0) {
                                text = '#' + text.replace(/#/g, '')
                            }
                            if (text.match(/^#[0-9A-Fa-f]{6}$/)) {
                                colorPreview.color = text
                            }
                        }

                        onAccepted: {
                            if (text.match(/^#[0-9A-Fa-f]{6}$/)) {
                                root.dotColor = text
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
                            text = text.replace(/[^0-9]/g, '')
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

                // 남은 하단 여백을 채워서 위쪽 요소들을 위로 밀어올리는 역할
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
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
        samples: 49           // 공식 권장값: radius * 2 + 1
        color: "#30000000"    // 핵심! 완전한 검은색이 아닌 반투명한 검은색을 써야 합니다.
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
