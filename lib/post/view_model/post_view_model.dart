import 'package:assignment/post/model/post_list_model.dart';
import 'package:assignment/post/model/user_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../repository/ApiRepository.dart';
import '../../repository/api_response.dart';

class PostViewModel extends ChangeNotifier{

  ApiResponse _apiResponse = ApiResponse.initial("initial stage");

  List<UserListModel?> _userListModel = [];

  List<PostListModel?> _postListModel = [];

  ApiResponse get response {
    return _apiResponse;
  }

  List<UserListModel?> get getUserListModel {
    return _userListModel;
  }

  List<PostListModel?> get getPostListModel {
    return _postListModel;
  }


  Future<void> getAutherList(BuildContext context) async {
    _apiResponse = ApiResponse.loading("loading stage");

    try {
      _userListModel= (await ApiRepository().getUserList(context));
      _postListModel= (await ApiRepository().getPostList(context));

    } catch (e) {

      if (kDebugMode) {
        print(e);
      }
    }
    _apiResponse = ApiResponse.completed("complete");

    notifyListeners();

  }


}