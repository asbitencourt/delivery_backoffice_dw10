import 'package:delivery_backoffice_dw10/src/repositories/auth/auth_repository.dart';
import 'package:delivery_backoffice_dw10/src/services/auth/login_service.dart';
import 'package:delivery_backoffice_dw10/src/storage/storage.dart';

import '../../core/global/constants.dart';

class LoginServiceImpl implements LoginService {
  final AuthRepository _authRepository;
  final Storage _storage;
  LoginServiceImpl(this._authRepository, this._storage);
  @override
  Future<void> execute(String email, String password) async {
    final authModel = await _authRepository.login(email, password);
    _storage.SetData(SessionStorageKeys.accessToken.key, authModel.accessToken);
  }
}
