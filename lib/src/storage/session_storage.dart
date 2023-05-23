import 'dart:html';
import 'package:delivery_backoffice_dw10/src/storage/storage.dart';

class SessionStorage extends Storage {
  @override
  void SetData(String key, String value) => window.sessionStorage[key] = value;

  @override
  void clean() => window.sessionStorage.clear();

  @override
  String getData(String key) => window.sessionStorage[key] ?? '';
}
