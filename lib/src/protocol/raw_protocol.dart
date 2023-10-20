import 'dart:convert';

import 'raw_protocol_decoder.dart';
import 'raw_protocol_encoder.dart';

/// Prisma PAW protocol.
class RawProtocol extends Codec {
  const RawProtocol();

  @override
  Converter get decoder => const RawProtocolDecoder();

  @override
  Converter get encoder => const RawProtocolEncoder();
}

const rawProtocol = RawProtocol();
