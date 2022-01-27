import sys

from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide2.QtWidgets import QApplication
from PySide2.QtCore import QUrl, Slot, QObject, qDebug
from QVTKFrameBufferObjectItem import FboItem
import vtk  # REQUIRES VTK < 9.0!!!


if __name__ == '__main__':

    app = QApplication()
    app.setApplicationName('Demo')
    qmlRegisterType(FboItem, 'QtVTK', 1, 0, 'VtkFboItem')

    engine = QQmlApplicationEngine()
    engine.load(QUrl.fromLocalFile('Demo/rect.qml'))

    # app.setup(engine)
    rootObject = engine.rootObjects()[0]
    vtkFboItem = rootObject.findChild(FboItem, 'vtkFboItem')

    sys.exit(app.exec_())