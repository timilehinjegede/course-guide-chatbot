import 'package:chatbot/data/models/models.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class StorageService {
  static Future<void> initStorageService() async {
    final appDocumentDirectory =
        await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(UserStateAdapter());

    await Hive.openBox(Strings.userBox);
    await Hive.openBox(Strings.userStateBox);
  }

  Box _userBox = Hive.box(Strings.userBox);
  Box _userStateBox = Hive.box(Strings.userStateBox);

  User getUser() {
    return _userBox.get(
      Strings.userBox,
      defaultValue: null,
    );
  }

  UserState getUserState() {
    return _userStateBox.get(
      Strings.userStateBox,
      defaultValue: UserState(
        isLoggedIn: false,
        hasStartedConvoWithBot: false,
        hasOnboarded: false,
        themeMode: Strings.darkThemeMode,
      ),
    );
  }

  void removeUser() {
    _userBox.clear();
  }

  void removeUserState() {
    _userStateBox.clear();
  }

  void saveUser({User user}) {
    _userBox.put(Strings.userBox, user);
  }

  void saveUserState({UserState userState}) {
    _userStateBox.put(Strings.userStateBox, userState);
  }
}
