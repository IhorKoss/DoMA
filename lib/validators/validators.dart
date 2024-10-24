class Validators {
  static String? Function(String?)? studentId = (String? value) {
    if (value == null || value.isEmpty) {
      return 'Це поле не може бути порожнім';
    }
    final studentIdRegExp = RegExp(r'^[A-Za-z]{2}\d{8}$');
    if (!studentIdRegExp.hasMatch(value)) {
      return 'Невірний формат студ. квитка';
    }
    return null;
  };
  static String? Function(String?)? email = (String? value) {
    if (value == null || value.isEmpty) {
      return 'Це поле не може бути порожнім';
    }
    final emailRegExp = RegExp(r'^((?!\.)[\w\-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Невірний формат email';
    }
    return null;
  };
  static String? Function(String?)? password = (String? value) {
    if (value == null || value.isEmpty) {
      return 'Це поле не може бути порожнім';
    }
    if (value.length < 8) {
      return 'Пароль повинен містити щонайменше 8 символів';
    }
    if(value.length>20){
      return 'Пароль повинен містити щонайбільше 20 символів';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Пароль повинен містити щонайменше одну велику літеру';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Пароль повинен містити щонайменше одну маленьку літеру';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Пароль повинен містити щонайменше одну цифру';
    }
    return null;
  };

}