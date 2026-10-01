// SPDX-License-Identifier: AGPL-3.0-only
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.streetpea.chiaking

Rectangle {
    id: header
    color: "#101820"
    implicitHeight: 110
    readonly property int nativePads: {
        let count = 0;
        for (let pad of Chiaki.controllers)
            if (pad.playStation) ++count;
        return count;
    }
    RowLayout {
        anchors.fill: parent
        anchors.margins: 22
        spacing: 20
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 6
            Label { text: "Your PS4. Your favourite spot."; font.pixelSize: 27; font.bold: true; color: "#f0f6fa" }
            Label { text: "Select a console to play  ·  Press L3 for setup help"; font.pixelSize: 17; color: "#a7bbc9" }
        }
        ColumnLayout {
            Layout.maximumWidth: 350
            Label {
                Layout.fillWidth: true
                wrapMode: Text.WordWrap
                font.pixelSize: 18
                font.bold: true
                color: header.nativePads > 0 ? "#68e2ba" : "#f0c579"
                text: header.nativePads > 0 ? "PlayStation controller connected" : Chiaki.controllers.length > 0 ? "Controller connected" : "Connect your DualShock 4"
            }
            Label { text: "USB or Bluetooth  ·  SteamOS"; color: "#a7bbc9"; font.pixelSize: 15 }
        }
    }
}
