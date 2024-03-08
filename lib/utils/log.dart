import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:music_tools/utils/path_constraint.dart';
import 'package:path/path.dart' as p;


/*
 * @Author ZISE
 * @Description //日志的工具类
 * @Date 15:42 2022/6/21
 **/
class Log {
  static Logger? _logger;

  static initLogger() async {
    File file = File(await filePath());
    final multiOutput = MultiOutput([FileOutput(file: file), ConsoleOutput()]);
    _logger = Logger(
      // level:  kDebugMode? Level.info : Level.info ,
      filter: ProductionFilter(),
        printer: PrefixPrinter(PrettyPrinter(
          stackTraceBeginIndex: 5,
          methodCount: 1,
          printEmojis: false,
          printTime: true,
        )),
        output: multiOutput);
  }

  static filePath() async {
    DateTime now = DateTime.now();
    Directory documentsFolder = await PathConstraint.getBaseDirPath();
    Directory fileFolder = Directory(p.join(documentsFolder.path, 'logger'));
    if (!await fileFolder.exists()) {
      await fileFolder.create(recursive: true);
    }
    delOldLogFile(fileFolder);
    return p.join(fileFolder.path, '${now.year}-${now.month}-${now.day}.log');
  }
  static delOldLogFile(Directory directory) async {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 60));
    Stream<FileSystemEntity> fileList = directory.list();
    await for (FileSystemEntity entity in fileList) {
      if (entity is File) {
        final fileCreationDate = entity.lastModifiedSync();
        if (fileCreationDate.isBefore(thirtyDaysAgo)) {
          entity.deleteSync();
        }
      }
    }
  }

  static void v(dynamic message) {
    _logger?.v(message);
  }

  static void d(dynamic message) {
    _logger?.d(message);
  }

  static void i(dynamic message) {
    _logger?.i(message);
  }

  static void w(dynamic message) {
    _logger?.w(message);
  }

  static void e(dynamic message) {
    _logger?.e(message);
  }
}
