// import 'package:flutter/material.dart';
import 'package:min3_twitwi/model/database/database_manager.dart';
import 'package:min3_twitwi/model/repository/user_repository.dart';
import 'package:min3_twitwi/viewmodel/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';




List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];



List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
    create: (_) => DatabaseManager(),
  )

];



List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, dbm, repo) => UserRepository(databaseManager: dbm),
  ),

];



List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
    ),
  )

];