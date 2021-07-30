import 'dart:convert';

class DB_Handler_Reservations {



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