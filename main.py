import sys

from PySide2.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide2.QtWidgets import QApplication
from PySide2.QtCore import QUrl, Slot, QObject, qDebug
from QVTKFrameBufferObjectItem import FboItem
import vtk  # REQUIRES VTK < 9.0!!!


class canvasHandler(QObject):

    def __init__(self, parent=None):
        super(canvasHandler, self).__init__(parent=parent)
        self.fbo = None
        self.actors = []

    # 点击 清除actor
    @Slot()
    def clearScene(self):
        for actor in self.actors:
            self.fbo.removeActor(actor, update=False)
        self.actors = []
        self.fbo.update()

    # 按钮点击添加vtk actor
    @Slot()
    def create_structure(self):
        # molecule
        mol = vtk.vtkMolecule()

        # hardcoded structure CO2
        a1 = mol.AppendAtom(6, 0.0, 0.0, 0.0)
        a2 = mol.AppendAtom(8, 0.0, 0.0, -1.0)
        a3 = mol.AppendAtom(8, 0.0, 0.0, 1.0)
        mol.AppendBond(a2, a1, 1)
        mol.AppendBond(a3, a1, 1)

        # hardcoded cell, cubic 10x10x10
        vector = vtk.vtkMatrix3x3()
        vector.DeepCopy([10, 0, 0,
                        0, 10, 0,
                        0, 0, 10])
        mol.SetLattice(vector)

        # Change lattice origin so molecule is in the centre
        mol.SetLatticeOrigin(vtk.vtkVector3d(-5.0, -5.0, -5.0))

        # Create a mapper and actor
        mapper = vtk.vtkMoleculeMapper()
        mapper.SetInputData(mol)

        actor = vtk.vtkActor()
        actor.SetMapper(mapper)
        self.actors.append(actor)
        self.fbo.addActors([actor])

        self.fbo.update()


if __name__ == '__main__':

    app = QApplication()
    app.setApplicationName('vtkMolecule_QML')
    qmlRegisterType(FboItem, 'QtVTK', 1, 0, 'VtkFboItem')

    engine = QQmlApplicationEngine()

    handler = canvasHandler()
    # Expose/Bind Python classes (QObject) to QML
    ctxt = engine.rootContext()  # returns QQmlContext
    ctxt.setContextProperty('canvasHandler', handler)

    engine.load(QUrl.fromLocalFile('main.qml'))

    # app.setup(engine)
    rootObject = engine.rootObjects()[0]
    vtkFboItem = rootObject.findChild(FboItem, 'vtkFboItem')

    handler.fbo = vtkFboItem


    rc = app.exec_()
    qDebug(f'CanvasHandler: Execution finished with return code: {rc}')
    sys.exit(rc)