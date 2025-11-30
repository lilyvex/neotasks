import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.components 3.0 as PlasmaComponents

PlasmoidItem {
    width: 200
    height: 100

    compactRepresentation: PlasmaComponents.Label {
        text: "Hello World!"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    fullRepresentation: ColumnLayout {
        PlasmaComponents.Label {
            text: "Hello World!"
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
