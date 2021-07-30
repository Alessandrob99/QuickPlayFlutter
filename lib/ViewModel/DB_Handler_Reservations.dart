import 'dart:convert';

class DB_Handler_Reservations {

  /*static void crypt(bool _isEncrypt,String _text) {
    int _key;
    String _temp = "";

    try {
      _key = 15;
    } catch (e) {
      print("Invalid Key");
    }

    for (int i = 0; i < _text.length; i++) {
      int ch = _text.codeUnitAt(i);
      int offset;
      String h;
      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0)) {
        offset = 97;
      } else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0)) {
        offset = 65;
      } else if (ch == ' '.codeUnitAt(0)) {
        _temp += " ";
        continue;
      } else {
        print("Invalid Test");
        _temp = "";
        break;
      }

      int c;
      if (_isEncrypt) {
        c = (ch + _key - offset) % 26;
      } else {
        c = (ch - _key - offset) % 26;
      }
      h = String.fromCharCode(c + offset);
      _temp += h;
    }

    print("Risultato : "+_temp);
  }*/


  static String crypt(String text, int shift){
    List<int> codeStr = [];
    int xxx = "1".codeUnitAt(0);
    int firstCharCode = "A".codeUnitAt(0);
    String newChar = String.fromCharCode(64);
    int offset = ("z".codeUnitAt(0) - "A".codeUnitAt(0)) +1;
    for(int i =0;i<text.length;i++){
      int oldCharCode = text[i].toString().codeUnitAt(0);
      //int oldIdxInAlphabet = oldCharCode - firstCharCode;
      int newIdxInAlphabet = (oldCharCode +shift);
      codeStr.add(newIdxInAlphabet);
    }
    String result = Utf8Decoder().convert(codeStr);

    return  result;
  }

  static String decrypt(String cryptedText, shift){
    return crypt(cryptedText, (-1)*shift);
  }


}