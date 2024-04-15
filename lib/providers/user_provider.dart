
import 'package:flutter/material.dart';
import 'package:peliculas_flutter/sqlite/database_helper.dart';

import '../models/models.dart';


class UserProvider extends ChangeNotifier{
 
  static List<User> _userList = [];
 
  List<User> get userList => _userList;
 
   
  Future<void> addUser(String usuario, String passw) async{   
    User user = User(usuario: usuario, passw: passw);
    await DatabaseManager.instance.createUser(user);
 
    listUsers();
  }
 
  Future<void> updateUser(User user) async{
    await DatabaseManager.instance.updateUser(user);
     
    listUsers();
  } 
 
  Future<void> deleteUser(int id) async{
    await DatabaseManager.instance.deleteUser(id);
 
    listUsers();
  }
 
  Future<void> listUsers() async{
    _userList = await DatabaseManager.instance.listUsers();
 
    notifyListeners();
  }
}