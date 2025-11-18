import 'package:instai/features/authorization/domain/entities/form_params_entity.dart';

class FormParamsModel {
  const FormParamsModel({required this.password, required this.username});

  final String username;
  final String password;

  factory FormParamsModel.fromEntity(FormParamsEntity entity) {
    return FormParamsModel(password: entity.password, username: entity.login);
  }

  Map<String, dynamic> toJson() {
    return {"username": username, "password": password};
  }
}
