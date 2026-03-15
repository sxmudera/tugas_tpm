import '../models/user_model.dart';

const List<UserModel> anggota = [
  UserModel(username: 'yoda',   password: 'yoda',   nama: 'Ayodya Enhanayoan',   nim: '123230099'),
  UserModel(username: 'ivan',   password: 'ivan',   nama: 'M. Ivan Samudera',    nim: '123230090'),
  UserModel(username: 'reyhan', password: 'reyhan', nama: 'Reyhan Nabil Destra', nim: '123230088'),
  UserModel(username: 'awab',   password: 'awab',   nama: 'Adib Fathani Awwab',  nim: '123230104'),
];

UserModel? authenticate(String username, String password) {
  try {
    return anggota.firstWhere(
      (u) => u.username == username && u.password == password,
    );
  } catch (_) {
    return null;
  }
}
