import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.12
import QtCharts 2.3
import QtVTK 1.0


ApplicationWindow {
    id: applicationwindow
    objectName: "applicationwindow"
    width: 1024
    height: 768

    VtkFboItem {
        id: vtkFboItem
        objectName: "vtkFboItem"
        x: 146
        y: 98

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

    ComboBox {
        id: comboBox
        objectName: "axisComboBox"
        x: 122
        y: 68
        font.pointSize: 20
        model: ["X Axis", 'Y Axis', 'Z Axis']
        currentIndex: 1
    }

    Text {
        id: text1
        objectName: "textDegree"
        x: 827
        y: 67
        width: 79
        height: 40
        text: qsTr("Degree")
        font.pixelSize: 25
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle {
        id: rectangle
        objectName: "rectangle"
        x: 760
        y: 67
        width: 55
        height: 40
        color: "lightgrey"
        border.color: "grey"

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
            font.pixelSize: 26
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }
    }

    Button {
        id: button
        objectName: "resetBtn"
        x: 462
        y: 19
        text: qsTr("Reset")
        font.pixelSize: 26
    }


    Item {
        id: sliderContainer
         objectName: "sliderContainer"
        x: 275
        y: 73
        width: 474
        height: 31
        Image {
            id: sliderContainerAsset
            source: "assets/sliderContainer.png"
        }

        Image {
            id: groove
            objectName: "groove"
            y: 0
            anchors.left: parent.left
            anchors.right: parent.right
            source: "assets/groove.png"
            anchors.leftMargin: 0
            anchors.rightMargin: 0
        }

        Image {
            id: handle
            objectName: "handle"
            x: 444
            y: 1
            anchors.verticalCenter: parent.verticalCenter
            anchors.bottom: parent.bottom
            source: "assets/handle.png"
            anchors.verticalCenterOffset: 0
            anchors.bottomMargin: 0
        }

        Slider {
            id: slider
            objectName: "slider"
            anchors.fill: parent
            value: 0
            stepSize: 1
            to: 180
        }
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:1}D{i:2}D{i:4}D{i:3}D{i:6}D{i:8}D{i:9}D{i:10}D{i:11}
D{i:7}D{i:12}
}
##^##*/
