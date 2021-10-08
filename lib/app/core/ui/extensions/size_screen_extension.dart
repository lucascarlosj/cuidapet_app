import 'package:flutter_screenutil/flutter_screenutil.dart';


//Extension basicamente é uma forma de adicionar funcionalidade dentro de bibliotecas existentes.
extension SizeScreenExtension on num {

  // Irá pegar o width da tela
  double get w => ScreenUtil().setWidth(this);

  // Irá pegar o height da tela
  double get h => ScreenUtil().setHeight(this);

  // Irá pegar o radius da tela
  double get r => ScreenUtil().radius(this);

  // Irá pegar a fonte dos textos
  double get sp => ScreenUtil().setSp(this);

  // Irá pegar o ScreenWidth da tela
  double get sw => ScreenUtil().screenWidth * this;

  // Irá pegar o ScreenHeight da tela
  double get sh => ScreenUtil().screenHeight * this;

  // Irá pegar o tamanho da status bar
  double get statusBarHeight => ScreenUtil().statusBarHeight * this;
}