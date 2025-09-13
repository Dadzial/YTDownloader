from PySide6 import QtCore
import yt_dlp
import os

class Downloader(QtCore.QObject):
    finished = QtCore.Signal(str)

    def __init__(self, parent=None):
        super().__init__(parent)

    @QtCore.Slot(str)
    def download(self, url: str):
        ydl_opts = {
            "outtmpl": "/home/damiand/Pobrane/%(title)s.%(ext)s",
            "format": "best",
        }

        try:
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                ydl.download([url])
            self.finished.emit("Download complete!")
        except Exception as e:
            self.finished.emit(f"Error: {e}")
