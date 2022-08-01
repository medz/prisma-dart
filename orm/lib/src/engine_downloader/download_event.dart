enum DownloadEvent {
  startDownload,
  doneDownload,
  startUnpack,
  doneUnpack,
  lookfile,
}

typedef DownloadEventHandler = void Function(DownloadEvent event);
