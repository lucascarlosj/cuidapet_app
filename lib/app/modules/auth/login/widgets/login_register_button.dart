import 'package:cuidapet_app/app/core/ui/cuidapet_icons.dart';
import 'package:cuidapet_app/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_app/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_app/app/core/ui/widgets/rounded_button_with_icon.dart';
import 'package:cuidapet_app/app/models/social_type.dart';
import 'package:cuidapet_app/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';

class LoginRegisterButton extends StatelessWidget {
  final LoginController _loginController;

  const LoginRegisterButton({Key? key, required LoginController loginController})
      : _loginController = loginController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        RoundedButtonWithIcon(
          color: const Color(0xff4267B3),
          icon: CuidapetIcons.facebook,
          width: .42.sw,
          title: 'Facebook',
          onTap: () {},
        ),
        RoundedButtonWithIcon(
          color: const Color(0xffE15031),
          icon: CuidapetIcons.google,
          width: .42.sw,
          title: 'Google',
          onTap: () => _loginController.socialLogin(SocialType.google)
        ),
        RoundedButtonWithIcon(
          color: context.primaryColorDark,
          icon: Icons.mail,
          width: .42.sw,
          title: 'Cadastre-se',
          onTap: () {
            Navigator.pushNamed(context, '/auth/register/');
          },
        ),
      ],
    );
  }
}
