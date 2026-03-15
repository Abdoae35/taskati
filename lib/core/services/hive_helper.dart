import 'package:hive_ce_flutter/adapters.dart';
import 'package:taskati/core/models/task_model.dart';

class HiveHelper {
  static late Box userBox;
  static late Box<TaskModel> taskBox;

  //box names
  static String userBoxName = 'user';
  static String taskBoxName = 'tasks';

  //keys
  static String nameKey = 'name';
  static String imageKey = 'imagePath';


  //init method to open boxes
  static Future<void> init() async {
    userBox = await Hive.openBox(userBoxName);
    taskBox = await Hive.openBox(taskBoxName);
  }

  //users box methods
  //set data
  static Future<void> setData(String name, String imagePath) async {
    await userBox.put(nameKey, name);
    await userBox.put(imageKey, imagePath);
  }

  //get data
  static dynamic getData(String key) {
    return userBox.get(key) ?? '';
  }

  static Future<void> setBool(String key, bool value) async {
    await userBox.put(key, value);
  }

  static bool? getBool(String key) {
    return userBox.get(key) ?? false;
  }

  //task box methods

  static dynamic cacheTask(String key, TaskModel value) async {
    await taskBox.put(key, value);
  }

  static TaskModel? getTask(String key) {
    return taskBox.get(key);
  }
}
