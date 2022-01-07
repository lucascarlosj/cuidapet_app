import 'package:cuidapet_app/app/models/confirm_login_model.dart';
import 'package:cuidapet_app/app/models/social_network_model.dart';
import 'package:cuidapet_app/app/models/user_model.dart';

abstract class UserRepository {
  Future<void> register(String email, String password);
  Future<String> login(String login, String password);
  Future<ConfirmLoginModel> confirmLogin();
  Future<UserModel> getUserLogged();
  Future<String> socialLogin(SocialNetworkModel socialModel);
}
