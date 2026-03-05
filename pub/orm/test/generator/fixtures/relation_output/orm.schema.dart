class _ModelMarker {
  const _ModelMarker();
}

const model = _ModelMarker();

@model
typedef User = ({String id, String email, List<Post> posts});

@model
typedef Post = ({String id, String userId, String title, User? author});
