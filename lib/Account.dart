import 'Displayable.dart';

class Account extends Displayable{

   String _username;
   String _email;
   String _password;
   DateTime  dateCreated;


   String getUsername() {
    return _username;
  }

   void setUsername(String _username) {
    this._username = _username;
  }

   String getEmail() {
    return _email;
  }

   void setEmail(String _email) {
    this._email = _email;
  }

   String getPassword() {
    return _password;
  }

   void setPassword(String _password) {
    this._password = _password;
  }

   DateTime getDateCreated() {
    return dateCreated;
  }

   void setDateCreated(DateTime dateCreated) {
    this.dateCreated = dateCreated;
  }


   Account() {
    this._username = "";
    this._email = "";
    this._password = "";
  }

   Account.fromAccount(Account account) {
    this._username = account._username;
    this._email = account._email;
    this._password = account._password;
  }
   Account.fromData(String _username, String _email, String _password)
  {
    this._username = _username;
    this._email = _email;
    this._password = _password;
  }


  }


