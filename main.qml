import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtCharts 2.3
import QtVTK 1.0
import QtQuick.Timeline 1.0

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

        Item {
            id: sliderContainer

            width: 474
            height: 31
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 100
            anchors.rightMargin: 50
            Image {
                id: sliderContainerAsset
                source: "Demo/assets/sliderContainer.png"
            }

            Image {
                id: groove
                y: 0
                anchors.left: parent.left
                anchors.right: parent.right
                source: "Demo/assets/groove.png"
                anchors.leftMargin: 0
                anchors.rightMargin: 0
            }

            Image {
                id: handle
                x: 444
                y: 1
                anchors.verticalCenter: parent.verticalCenter
                anchors.bottom: parent.bottom
                source: "Demo/assets/handle.png"
                anchors.verticalCenterOffset: 0
                anchors.bottomMargin: 0
            }

            Slider {
                id: slider
                objectName: "slider"
                opacity: 0
                anchors.fill: parent
                value: 0
                stepSize: 1
                to: 180
            }
        }

        Timeline {
            id: timeline
            currentFrame: slider.value
            KeyframeGroup {
                target: handle
                property: "x"
                Keyframe {
                    value: 444
                    frame: 180
                }

                Keyframe {
                    value: 0
                    frame: 0
                }
            }
            endFrame: 180
            enabled: true
            startFrame: 0
        }

    }
}
/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}D{i:2}D{i:4}D{i:6}D{i:5}
D{i:8}D{i:9}D{i:11}D{i:12}D{i:13}D{i:14}D{i:10}D{i:1}
}
##^##*/
