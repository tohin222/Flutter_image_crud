import 'package:flutter/foundation.dart';
import 'package:image_map/models/place.dart';
import 'dart:io';
import 'package:image_map/helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: pickedTitle,
        location: null);
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DbHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: null))
        .toList();
    notifyListeners();
  }

  Future<void> deleteSingle(int id) async {
    await DbHelper.deleteData(id);
    notifyListeners();
    print('jjk');
  }
//  void deleteTask(Task task) {
//    _tasks.remove(task);
//    notifyListeners();
//  }
}
