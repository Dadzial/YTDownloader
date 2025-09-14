# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtGui import QIcon

from Downloader import Downloader

if __name__ == "__main__":
    app = QApplication(sys.argv)


    downloader = Downloader()

    icon_path = Path(__file__).parent / "icons/app_icon.png"
    app.setWindowIcon(QIcon(str(icon_path)))

    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("downloader", downloader)
    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(str(qml_file))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
