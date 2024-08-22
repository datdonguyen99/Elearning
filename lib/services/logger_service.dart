import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:elearning/extensions/l10n.dart';

class Logger {
  String _logs = '';
  int _logCount = 0;

  void log(String errLocation, Object? err, StackTrace? stackTrace) {
    final timestamp = DateTime.now().toString();

    final errMessage = err != null ? '$err' : '';

    final stackTraceMessage = stackTrace != null ? '$stackTrace' : '';

    final logMessage =
        '[$timestamp] $errLocation:$errMessage\n$stackTraceMessage';

    debugPrint(logMessage);
    _logs += '$logMessage\n';
    _logCount++;
  }

  Future<String> copyLogs(BuildContext context) async {
    try {
      if (_logs != '') {
        await Clipboard.setData(ClipboardData(text: _logs));
        // ignore: use_build_context_synchronously
        return '${context.l10n!.copyLogsSuccess}.';
      } else {
        return '${context.l10n!.copyLogsNoLogs}.';
      }
    } catch (e, stackTrace) {
      log('Error copying logs', e, stackTrace);
      return 'Error: $e';
    }
  }

  int getLogCount() {
    return _logCount;
  }
}
