# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
<<<<<<< HEAD

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
=======
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtGui import QIcon

>>>>>>> 8080e82 (end of project)

from Downloader import Downloader

if __name__ == "__main__":
<<<<<<< HEAD
    app = QGuiApplication(sys.argv)

    downloader = Downloader()
=======
    app = QApplication(sys.argv)
    downloader = Downloader()
    icon_path = Path(__file__).parent / "icons/app_icon.png"
    app.setWindowIcon(QIcon(str(icon_path)))
>>>>>>> 8080e82 (end of project)

    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("downloader", downloader)
    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
