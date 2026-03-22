import QtQuick

// 십자선 팔 공통 컴포넌트 — Behavior 애니메이션 내장
Rectangle {
    Behavior on width { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on height { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on radius { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on topLeftRadius { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on topRightRadius { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on bottomLeftRadius { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on bottomRightRadius { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on color { ColorAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on opacity { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on anchors.topMargin { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on anchors.bottomMargin { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on anchors.leftMargin { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
    Behavior on anchors.rightMargin { NumberAnimation { duration: Theme.animDuration; easing.type: Easing.OutCubic } }
}
