import 'dart:io';

import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:flutter/material.dart';

class DirectoryHandlerStaticClass {
  static Future<Directory?> pickDirectory(
      BuildContext context, Directory directory) async {
    if (directory == null) {
      directory = Directory(FolderPicker.rootPath);
    }

    Directory? newDirectory = await FolderPicker.pick(
        allowFolderCreation: true,
        context: context,
        rootDirectory: directory,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))));
    return newDirectory;
  }
}
