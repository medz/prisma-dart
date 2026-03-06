class _ModelMarker {
  const _ModelMarker();
}

const model = _ModelMarker();

@model
typedef CliOnlyUser = ({int id, String email});
