import 'package:form_field_validator/form_field_validator.dart';

final validatedEmail = MultiValidator([
  RequiredValidator(errorText: 'Champs obligatoire'),
  EmailValidator(errorText: 'Email invalide')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Champs obligatoire '),
  MinLengthValidator(8, errorText: 'Minimum 8 caractères')
]);

final passwordRepeatValidator = MultiValidator([
  RequiredValidator(errorText: 'Retapez le mot de passe est requis'),
]);

final validatedPhoneForm = MultiValidator([
  RequiredValidator(errorText: 'Champs obligatoire'),
  MinLengthValidator(8, errorText: 'Minimum 8 chiffres')
]);
final validatedstockForm = MultiValidator([
  RequiredValidator(errorText: 'Champs obligatoire'),
  /* PatternValidator(r'^[1-9]+[0-9]*$',
      errorText: 'stock doit etre nombre positive')*/
]);
final validatedPriceForm = MultiValidator([
  RequiredValidator(errorText: 'Champs obligatoire'),
  /*PatternValidator(r'^[1-9]+[0-9]*$',
      errorText: 'prix doit etre nombre positive'),*/
]);
