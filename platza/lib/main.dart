// 後方互換の既定エントリポイント。
// `flutter run` のようにエントリポイント未指定で実行された場合は dev flavor で起動する。
// 明示的に flavor を指定する場合は `lib/main_dev.dart` または `lib/main_prod.dart` を
// `-t` で指定すること。
import 'package:platza/main_dev.dart' as dev;

Future<void> main() => dev.main();
