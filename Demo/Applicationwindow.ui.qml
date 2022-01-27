import QtQuick3D 1.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Timeline 1.0

Item {
    id: applicationwindow
    width: 1024
    height: 768

    Image {
        id: applicationwindowAsset
        x: 0
        y: 0
        //source: "assets/applicationwindow.png"

        ComboBox {
            id: comboBox
            objectName: "axisComboBox"
            x: 122
            y: 640
            font.pointSize: 20
            model: ["X Axis", 'Y Axis', 'Z Axis']
            currentIndex: 1
        }

        Text {
            id: text1
            x: 827
            y: 639
            width: 79
            height: 40
            text: qsTr("Degree")
            font.pixelSize: 25
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: rectangle
            x: 760
            y: 639
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
            y: 591
            text: qsTr("Reset")
            font.pixelSize: 26
        }
    }

    Image {
        id: view3DPlaceHolder
        x: 146
        y: 98
        source: "assets/view3DPlaceHolder.png"
    }

    Item {
        id: sliderContainer
        x: 275
        y: 645
        width: 474
        height: 31
        Image {
            id: sliderContainerAsset
            source: "assets/sliderContainer.png"
        }

        Image {
            id: groove
            y: 0
            anchors.left: parent.left
            anchors.right: parent.right
            source: "assets/groove.png"
            anchors.leftMargin: 0
            anchors.rightMargin: 0
        }

        Image {
            id: handle
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
            opacity: 0
            anchors.fill: parent
            value: 0
            stepSize: 1
            to: 180
        }
    }

    Item {
        id: vtkcontainer
        objectName: "vtkcontainer"
        //anchors.fill: parent
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

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66;uuid:"51bb67aa-f2b8-4a30-8abe-339259851b7a"}D{i:2}D{i:3}
D{i:5}D{i:4}D{i:7}D{i:1;uuid:"30577e49-c9d0-439c-aff3-3252b5b95c2b"}D{i:8}D{i:10}
D{i:11}D{i:12}D{i:13}D{i:9}D{i:15}D{i:17}D{i:18}D{i:19}D{i:16}D{i:14}D{i:20}
}
##^##*/

