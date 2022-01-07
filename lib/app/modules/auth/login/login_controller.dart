import 'package:cuidapet_app/app/core/exceptions/user_not_found_excepetion.dart';
import 'package:cuidapet_app/app/core/helpers/logger.dart';
import 'package:cuidapet_app/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_app/app/core/ui/widgets/messages.dart';
import 'package:cuidapet_app/app/models/social_type.dart';
import 'package:cuidapet_app/app/services/user/user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;


abstract class _LoginControllerBase with Store {
  final UserService _userService;
  final Logger _log;

  _LoginControllerBase({required UserService userService, required Logger log})
      : _userService = userService,
        _log = log;

  Future<void> login(String login, String password) async {
    try {
      Loader.show();
      await _userService.login(login, password);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on UserNotFoundExcepetion {
      Loader.hide();
      Messages.alert('Login ou senha invalidos');
    } catch (e, s) {
      Loader.hide();
      _log.error('Erro ao realizar login!', e, s);
      Messages.alert('Erro ao realizar login, tente novamente mais tarde!');
    }
  }

  Future<void> socialLogin(SocialType loginType) async{
    try {
      Loader.show();
      await _userService.socialLogin(loginType);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } catch (e, s) {
      Loader.hide();
      _log.error('Erro ao realizar login!', e, s);
      Messages.alert('Erro ao realizar login!');
    }
  }
}
