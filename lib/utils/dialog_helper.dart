
import 'package:flutter/material.dart';
import 'package:quickplay/widgets/dialog_exit.dart';

class DialogHelper {

  static exit(context) => showDialog(context: context, builder: (context) => ExitConfirmationDialog());
}