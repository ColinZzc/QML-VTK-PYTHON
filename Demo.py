import os.path
import sys

from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide2.QtWidgets import QApplication
from PySide2.QtCore import QUrl, Slot, QObject
from QQmlVTKPlugin.QVTKFrameBufferObjectItem import FboItem
import vtk  # REQUIRES VTK < 9.0!!!

# 获取exe之后运行时解压的资源文件目录
import os, sys
def base_path(path):
  if getattr(sys, 'frozen', None):
    basedir = sys._MEIPASS
  else:
    basedir = os.path.dirname(__file__)
  return os.path.join(basedir, path)


if __name__ == '__main__':

    app = QApplication()
    app.setApplicationName('Demo')
    # 注册QML组件
    qmlRegisterType(FboItem, 'QtVTK', 1, 0, 'VtkFboItem')
    # 载入QML文件
    engine = QQmlApplicationEngine()

    # 将整个应用程序工作路径设置成exe运行时解压资源的文件路径
    os.chdir(base_path(''))
    engine.load('Demo/rect.qml')
    # 或者 只在这里 指向解压资源的文件夹
    # engine.load(base_path('Demo/rect.qml'))

    # 获取qml中的组件
    rootObject = engine.rootObjects()[0]
    vtkFboItem = rootObject.findChild(FboItem, 'vtkFboItem')
    createBtn = rootObject.findChild(QObject, 'createScene')
    cleanBtn = rootObject.findChild(QObject, 'clearScene')
    inputText = rootObject.findChild(QObject, 'inputText')
    comboBox = rootObject.findChild(QObject, 'comboBox')
    slider = rootObject.findChild(QObject, 'slider')
    # VTK 中的 Actor
    actors = []


    @Slot()
    def receive_slider():
        angle = slider.property("value")
        print(f"slider {angle}")
        inputText.setProperty("text", int(angle))
        vtkFboItem.getCamera().Azimuth(4)
        vtkFboItem.update()

    slider.moved.connect(receive_slider)


    @Slot(int)
    def receive_axis(combo_box_index):
        print(combo_box_index)
        print(comboBox.property("currentText"))


    comboBox.activated.connect(receive_axis)


    @Slot()
    def receive_text():
        new_angle = inputText.property("text")
        print(new_angle)
        slider.setProperty("value", int(new_angle) / 2)


    inputText.editingFinished.connect(receive_text)

    # VTK 中的 Actor
    actors = []


    @Slot()
    def receive_create_scene_button_clicked():
        print("create vtk actor")
        # Create source
        source = vtk.vtkSphereSource()
        source.SetCenter(0, 0, 0)
        source.SetRadius(5.0)
        # Create a mapper
        mapper = vtk.vtkPolyDataMapper()
        mapper.SetInputConnection(source.GetOutputPort())
        # Create an actor
        actor = vtk.vtkActor()
        actor.SetMapper(mapper)

        actors.append(actor)

        vtkFboItem.addActors(actors)


    createBtn.clicked.connect(receive_create_scene_button_clicked)


    @Slot()
    def receive_clean_scene_button_clicked():
        print("create vtk actor")
        global actors
        for actor in actors:
            vtkFboItem.removeActor(actor)
        actors = []


    cleanBtn.clicked.connect(receive_clean_scene_button_clicked)
    app.exec_()

    sys.exit()
