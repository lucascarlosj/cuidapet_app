import 'package:cuidapet_app/app/models/social_network_model.dart';

abstract class SocialRepository {
  Future<SocialNetworkModel> googleLogin();
}
