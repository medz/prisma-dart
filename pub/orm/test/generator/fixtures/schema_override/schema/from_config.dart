class _ModelMarker {
  const _ModelMarker();
}

const model = _ModelMarker();

@model
typedef ConfigOnlyUser = ({int id, String email});
