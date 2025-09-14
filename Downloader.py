<<<<<<< HEAD
from PySide6 import QtCore
import yt_dlp
import os

class Downloader(QtCore.QObject):
    finished = QtCore.Signal(str)
=======
from PySide6.QtWidgets import QFileDialog
from PySide6.QtCore import QObject, Signal, Slot
import yt_dlp

class Downloader(QObject):
    finished = Signal(str)
>>>>>>> 8080e82 (end of project)

    def __init__(self, parent=None):
        super().__init__(parent)

<<<<<<< HEAD
    @QtCore.Slot(str)
    def download(self, url: str):
        ydl_opts = {
            "outtmpl": "/home/damiand/Pobrane/%(title)s.%(ext)s",
            "format": "best",
        }

=======
    @Slot(str,str,str)
    def download(self, url: str, format:str ,path :str):

        format_map = {
            "mp4": "bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4",
            "webm": "bestvideo[ext=webm]+bestaudio[ext=webm]/webm",
            "mp3": "bestaudio/best"
        }
        ydl_opts = {
            "outtmpl": f"{path}/%(title)s.%(ext)s",
            "format": format_map.get(format, "best")
        }
        if format == "mp3":
            ydl_opts["postprocessors"] = [{
                "key": "FFmpegExtractAudio",
                "preferredcodec": "mp3",
                "preferredquality": "192"
        }]
<<<<<<< HEAD
>>>>>>> 8080e82 (end of project)
=======

>>>>>>> 46b44e9 (end of project)
        try:
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                ydl.download([url])
            self.finished.emit("Download complete!")
        except Exception as e:
            self.finished.emit(f"Error: {e}")
<<<<<<< HEAD
=======
    @Slot(result=str)
    def choose_folder(self):
        folder = QFileDialog.getExistingDirectory(None, "Select folder")
        return folder if folder else ""


>>>>>>> 8080e82 (end of project)
