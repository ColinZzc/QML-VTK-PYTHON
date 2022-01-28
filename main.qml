import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtCharts 2.3
import QtVTK 1.0

Window {
    id: root
    minimumWidth: 1024
    minimumHeight: 700
    visible: true
    color: "#00ffffff"
    title: "QtVTK-Py"


    Rectangle {
        id: screenCanvasUI
        anchors.fill: parent

        VtkFboItem {
            id: vtkFboItem
            objectName: "vtkFboItem"
            anchors.fill: parent

            MouseArea {
                acceptedButtons: Qt.AllButtons
                anchors.fill: parent
                scrollGestureEnabled: false

                onPositionChanged: (mouse) => {
                    //canvasHandler.mouseMoveEvent(pressedButtons, mouseX, mouseY);
                   mouse.accepted = false;
                }
                onPressed: (mouse) => {
                    //canvasHandler.mousePressEvent(pressedButtons, mouseX, mouseY);
                    mouse.accepted = false;
                    // if u want to propagate the pressed event
                    // so the VtkFboItem instance can receive it
                    // then uncomment the belowed line
                    // mouse.ignore() // or mouse.accepted = false
                }
                onReleased: (mouse) => {
                    //canvasHandler.mouseReleaseEvent(pressedButtons, mouseX, mouseY);
                    print(mouse);
                    mouse.accepted = false;
                }
                onWheel: (wheel) => {
                    wheel.accepted = false;
                }
            }
        }

        Button {
            id: clearScene
            text: "Clear Scene"
            highlighted: true
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 50
            onClicked: canvasHandler.clearScene()

            ToolTip.visible: hovered
            ToolTip.delay: 1000
            ToolTip.text: "Show 2D Chart in right corner"
        }

        Rectangle {
                id: rectangle
                objectName: "rectangle"

                width: 71
                height: 27
                color: "lightgrey"
                border.color: "grey"
                anchors.right: comboBox.left
                anchors.bottom: parent.bottom
                anchors.rightMargin: 50
                anchors.bottomMargin: 50

                TextInput {
                    id: textEdit
                    objectName: "angleText"
                    validator: IntValidator {
                        bottom: 0
                        top: 360
                    }
                    maximumLength: 3
                    text: qsTr("0")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                }
            }

        Button {
            id: createScene
            text: "Create Lattice"
            highlighted: true
            anchors.right: clearScene.left
            anchors.bottom: parent.bottom
            anchors.margins: 50
            onClicked: canvasHandler.create_structure()

            ToolTip.visible: hovered
            ToolTip.delay: 1000
            ToolTip.text: "Open a 3D model into the canvas"
        }

        ComboBox {
            id: comboBox
            x: 265
            y: 410
            anchors.right: createScene.left
            anchors.bottom: parent.bottom
            anchors.margins: 50
            model: ["X Axis", 'Y Axis', 'Z Axis']
            currentIndex: 1
        }

    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:2}D{i:4}D{i:6}D{i:5}D{i:8}D{i:9}D{i:1}
}
##^##*/
