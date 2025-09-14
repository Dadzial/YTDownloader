from PySide6.QtWidgets import QFileDialog
from PySide6.QtCore import QObject, Signal, Slot
import yt_dlp

class Downloader(QObject):
    finished = Signal(str)

    def __init__(self, parent=None):
        super().__init__(parent)

    @Slot(str, str, str)
    def download(self, url: str, format: str, path: str):

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

        try:
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                ydl.download([url])
            self.finished.emit("Download complete!")
        except Exception as e:
            self.finished.emit(f"Error: {e}")

    @Slot(result=str)
    def choose_folder(self):
        folder = QFileDialog.getExistingDirectory(None, "Select folder")
        return folder if folder else ""
