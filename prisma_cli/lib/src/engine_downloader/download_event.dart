enum DownloadEvent {
  startDownload,
  doneDownload,
  startUnpack,
  doneUnpack,
  lookfile,
  done,
}

typedef DownloadEventHandler = void Function(DownloadEvent event);
