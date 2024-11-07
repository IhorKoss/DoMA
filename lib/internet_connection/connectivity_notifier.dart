import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../database/mongo_service.dart';
import '../widgets/no_interned_dialog.dart';

class ConnectivityNotifier extends StatefulWidget {
  final Widget child;

  const ConnectivityNotifier({required this.child, Key? key}) : super(key: key);

  @override
  _ConnectivityNotifierState createState() => _ConnectivityNotifierState();
}

class _ConnectivityNotifierState extends State<ConnectivityNotifier> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _isConnected = true;
  bool _isDialogOpen = false;
  @override
  void initState() {
    super.initState();
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.contains(ConnectivityResult.none)) {
        if (!_isDialogOpen) {
          _isDialogOpen = true;
          NoInternetDialog.show(context);
          _isDialogOpen = false;
        }
        _isConnected = false;
      } else {
        if (!_isConnected) {
          _isConnected = true;
          MongoService.retryConnection(context);
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
