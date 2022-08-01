enum DownloadEvent {
  progress,
  done,
  unpack,
  lookfile,
}

typedef DownloadEventHandler = void Function(DownloadEvent event);
