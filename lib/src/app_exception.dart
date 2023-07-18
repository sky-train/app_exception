import 'package:logging/logging.dart';

abstract class AppException implements Exception {
  String? _code;
  Object? _parent;
  String? _message;
  final Map<String, Object?> _props = {};
  final Map<String, Object?> _context = {};

  String get code => _code ?? runtimeType.toString();

  String? get message => _message;

  Map<String, Object?> get props => _props;

  Map<String, Object?> get context => _context;

  AppException([this._message]);

  @override
  String toString() {
    return "[$code] ${message ?? ''}";
  }

  void setCode(String code) {
    if (_code == null) {
      _code = code;
    } else {
      // log warn
    }
  }

  void setParent(Object exception) {
    if (_parent == null) {
      _parent = exception;
    } else {
      // log warn
    }
  }

  void setMessage(String message) {
    _message = message;
  }

  void setProps(Map<String, Object?> props) {
    _props.addAll(props);
  }

  void setContext(Map<String, Object?> context) {
    _context.addAll(context);
  }

  void print([String? message]) {
    _logger.shout(message, this);
  }

  static final Logger _logger = Logger("AppException");

  static Logger get logger {
    return _logger;
  }
}

class UnhandledException extends AppException {
  UnhandledException(Object parent) {
    setParent(parent);
  }

  static AppException wrapIfNotAppException(Object err) {
    if (err is! AppException) {
      return UnhandledException(err);
    }
    return err;
  }
}
