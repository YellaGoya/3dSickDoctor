import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: about

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

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
            text: "Version : v.1.0.0\nEmail : he2kape@gmail.com"
            font.pixelSize: 14
            font.family: sf.name
            color: "#101010"
            verticalAlignment: Text.AlignVCenter
        }

        // Text {
        //     Layout.preferredHeight: 32
        //     text: ""
        //     font.pixelSize: 14
        //     font.family: sf.name
        //     color: "#101010"
        //     verticalAlignment: Text.AlignVCenter
        // }

        Text {
            Layout.preferredHeight: 32
            Layout.topMargin: 20
            text: "Magick by roscoe yoon"
            font.pixelSize: 14
            font.family: sf.name
            font.weight: Font.Medium
            color: "#101010"
            opacity: 0.7
            verticalAlignment: Text.AlignVCenter
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
