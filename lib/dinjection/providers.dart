import 'package:min3_twitwi/model/database/database_manager.dart';
import 'package:min3_twitwi/model/location/location_manager.dart';
import 'package:min3_twitwi/model/repository/post_repository.dart';
import 'package:min3_twitwi/model/repository/user_repository.dart';
import 'package:min3_twitwi/viewmodel/comment_view_model.dart';
import 'package:min3_twitwi/viewmodel/feed_view_model.dart';
import 'package:min3_twitwi/viewmodel/login_view_model.dart';
import 'package:min3_twitwi/viewmodel/post_view_model.dart';
import 'package:min3_twitwi/viewmodel/profile_view_model.dart';
import 'package:min3_twitwi/viewmodel/search_view_model.dart';
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
  ),
  Provider<LocationManager>(
    create: (_) => LocationManager(),
  ),

];




List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, dbm, repo) => UserRepository(databaseManager: dbm),
  ),
  ProxyProvider2<DatabaseManager, LocationManager, PostRepository>(
    update: (_, dbm, lom, repo) => PostRepository(
      databaseManager: dbm,
      locationManager: lom,
    ),
  ),

];



List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<PostViewModel>(
    create: (context) => PostViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
      postRepository: Provider.of<PostRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<FeedViewModel>(
    create: (context) => FeedViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
      postRepository: Provider.of<PostRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<CommentViewModel>(
    create: (context) => CommentViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
      postRepository: Provider.of<PostRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<ProfileViewModel>(
    create: (context) => ProfileViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
      postRepository: Provider.of<PostRepository>(context, listen: false),
    ),
  ),
  ChangeNotifierProvider<SearchViewModel>(
    create: (context) => SearchViewModel(
      userRepository: Provider.of<UserRepository>(context, listen: false),
    ),
  ),

];