import 'package:get/get_navigation/src/root/internacionalization.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "back": "Back",
          "start": "Start",
          "pause": "Pause",
          "scanTheProduct": "Scan the product",
          "color": "Color",
          "size": "Size",
          "cancel": "Cancel",
          "signIn": "Sign In",
        },
        'uk_UA': {
          "back": "Назад",
          "start": "Початок",
          "pause": "Пауза",
          "scanTheProduct": "Сканувати продукт",
          "color": "Колір",
          "size": "Розмір",
          "cancel": "Скасувати",
          "signIn": "Увійти",
        },
        'ru_RU': {
          "back": "Назад",
          "start": "Начать",
          "pause": "Пауза",
          "scanTheProduct": "Сканировать продукт",
          "color": "Цвет",
          "size": "Размер",
          "cancel": "Отмена",
          "signIn": "Войти",
        },
      };
}
