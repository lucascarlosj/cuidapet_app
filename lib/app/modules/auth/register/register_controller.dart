import 'package:cuidapet_app/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_app/app/core/helpers/logger.dart';
import 'package:cuidapet_app/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_app/app/core/ui/widgets/messages.dart';
import 'package:cuidapet_app/app/services/user/user_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'register_controller.g.dart';

class RegisterController = _RegisterControllerBase with _$RegisterController;

abstract class _RegisterControllerBase with Store {
  final UserService _userService;
  final Logger _log;

  _RegisterControllerBase({
    required UserService userService,
    required Logger log,
  })  : _userService = userService,
        _log = log;

  Future<void> register(String email, String password) async {
    try {
      Loader.show();
      await _userService.register(email, password);
      Loader.hide();
      Modular.to.popAndPushNamed('/auth/');
      Messages.info('Usuario Cadastrado com sucesso');
    } on UserExistsException {
      Loader.hide();
      Messages.alert('E-mail já cadastrado, por favo escolha outro!');
    } catch (e, s) {
      _log.error('Erro ao registrar usuário', e, s);
      Loader.hide();
      Messages.alert('Erro ao registrar usuário, tente novamente mais tarde');
    }
  }
}
