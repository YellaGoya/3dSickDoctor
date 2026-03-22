import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: about

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Text {
            Layout.preferredHeight: 32
            Layout.bottomMargin: 20

            text: "3D Sick Doctor info"
            font.pixelSize: 16
            font.family: sf.name
            font.weight: Font.Medium
            verticalAlignment: Text.AlignVCenter
            opacity: 0.7
        }

        Text {
            Layout.preferredHeight: 32
            text: "Version : v.1.2.0\nEmail : he2kape@gmail.com"
            font.pixelSize: 14
            font.family: sf.name
            color: Theme.textPrimary
            verticalAlignment: Text.AlignVCenter
        }

        Text {
            Layout.preferredHeight: 32
            Layout.topMargin: 20
            Layout.bottomMargin: 10
            text: "Changelog"
            font.pixelSize: 14
            font.family: sf.name
            font.weight: Font.Medium
            color: Theme.textPrimary
            opacity: 0.7
            verticalAlignment: Text.AlignVCenter
        }

        ScrollView {
            id: aboutScrollView
            Layout.fillWidth: true
            Layout.fillHeight: true

            contentWidth: width
            clip: true

            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout {
                width: aboutScrollView.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 24
                spacing: 16

                // v.1.2.0
                ColumnLayout {
                    spacing: 4

                    Text {
                        text: "v.1.2.0 — 2026.03.22"
                        font.pixelSize: 13
                        font.family: sf.name
                        font.weight: Font.Medium
                        color: Theme.accentText
                    }

                    Text {
                        Layout.fillWidth: true
                        text: "• Theme 시스템 도입 (색상/애니메이션 상수 중앙 관리)\n" + "• CrossArm 공통 컴포넌트로 십자선 코드 간소화\n" + "• ConfigManager를 별도 파일로 분리\n" + "• 색상 변환 유틸 함수 Theme.toHex() 추가\n" + "• 도트 중앙 점 표시 On/Off 옵션 추가\n" + "• 십자선 중앙 십자 표시 On/Off 옵션 추가\n" + "• Auto Save 기능 추가 (150ms debounce)\n" + "• 트레이 아이콘 더블클릭으로 설정창 열기\n" + "• ColorBar 클릭 시 색상 미적용 버그 수정"
                        font.pixelSize: 12
                        font.family: sf.name
                        color: Theme.textPrimary
                        lineHeight: 1.4
                        wrapMode: Text.WordWrap
                    }
                }

                // v.1.1.0
                ColumnLayout {
                    spacing: 4

                    Text {
                        text: "v.1.1.0"
                        font.pixelSize: 13
                        font.family: sf.name
                        font.weight: Font.Medium
                        color: Theme.accentText
                    }

                    Text {
                        Layout.fillWidth: true
                        text: "• 설정 UI 구현 (Dot/Cross/About 탭)\n" + "• HSV 색상 선택기 (ColorBar) 추가\n" + "• 시스템 트레이 아이콘 및 메뉴\n" + "• 설정 파일 영속화 (configs.json)\n" + "• 실시간 프리뷰 애니메이션"
                        font.pixelSize: 12
                        font.family: sf.name
                        color: Theme.textPrimary
                        lineHeight: 1.4
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }

        Text {
            Layout.preferredHeight: 32
            Layout.topMargin: 10
            text: "Magick by roscoe yoon"
            font.pixelSize: 14
            font.family: sf.name
            font.weight: Font.Medium
            color: Theme.textPrimary
            opacity: 0.7
            verticalAlignment: Text.AlignVCenter
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
