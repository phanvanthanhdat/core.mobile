
import 'package:flutter/cupertino.dart';

abstract class BaseUseCase {
  final BuildContext _context;
  BuildContext get context => _context;
  BaseUseCase(this._context);
}