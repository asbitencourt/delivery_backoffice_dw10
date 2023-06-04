import 'package:delivery_backoffice_dw10/src/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel> getById(int id);
}
