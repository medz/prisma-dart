enum ErrorFormat { pretty, colorless, minimal }

class PrismaClientOptions {
  const PrismaClientOptions({
    required this.errorFormat,
    required this.datasourceUrl,
  });

  final ErrorFormat errorFormat;
  final String datasourceUrl;
}

class PrismaClient {
  factory PrismaClient({
    ErrorFormat? errorFormat,
    required String datasourceUrl,
  }) {
    final options = PrismaClientOptions(
      errorFormat: errorFormat ?? ErrorFormat.colorless,
      datasourceUrl: datasourceUrl,
    );

    return PrismaClient._(options);
  }

  const PrismaClient._(this.options);
  final PrismaClientOptions options;
}
