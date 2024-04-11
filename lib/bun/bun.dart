import 'package:orm/_internal/project_directory.dart';
import 'package:path/path.dart';

/// Bun executable binary path.
final String _bunExecutable =
    join(projectDirectory.path, '.dart_tool', 'prisma', 'bun');
