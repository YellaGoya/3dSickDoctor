pragma Singleton
import QtQuick

QtObject {
    // Background
    readonly property color background: "#f9f9f9"
    readonly property color surface: "#fafafa"
    readonly property color backgroundHover: "#f0f0f0"

    // Text
    readonly property color textPrimary: "#101010"
    readonly property color textSecondary: "#404040"
    readonly property color textTertiary: "#808080"

    // Border
    readonly property color border: "#d0d0d0"
    readonly property color borderFocused: "#a0a0a0"
    readonly property color separator: "#e0e0e0"

    // Accent
    readonly property color accent: "#519cff"
    readonly property color accentText: "#2378ff"
    readonly property color accentHover: "#202378ff"

    // Misc
    readonly property color dark: "#303030"
    readonly property color shadowLight: "#20000000"
    readonly property color shadowMedium: "#30000000"

    // Animation
    readonly property int animDuration: 250
    readonly property int animDurationFast: 150

    // Color utility: QML color (#AARRGGBB) → hex (#RRGGBB uppercase)
    function toHex(c) {
        var s = c.toString()
        return (s.length === 9 ? "#" + s.substring(3) : s).toUpperCase()
    }
}
