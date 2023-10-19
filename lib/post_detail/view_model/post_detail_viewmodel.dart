import 'package:assignment/post_detail/model/post_detail_model.dart';
import 'package:assignment/post_detail/model/post_detail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../repository/ApiRepository.dart';
import '../../repository/api_response.dart';

class PostDetailViewModel extends ChangeNotifier{

  ApiResponse _apiResponse = ApiResponse.initial("initial stage");

  PostDetailModel? _postDetailModel = PostDetailModel();

  ApiResponse get response {
    return _apiResponse;
  }

  PostDetailModel? get getPostDetailModel {
    return _postDetailModel;
  }


  Future<void> getPostDetail(String id,BuildContext context) async {
    _apiResponse = ApiResponse.loading("loading stage");

    try {
      _postDetailModel= (await ApiRepository().getPostDetail(id,context));


    } catch (e) {

      if (kDebugMode) {
        print(e);
      }
    }
    _apiResponse = ApiResponse.completed("complete");

    notifyListeners();

  }

}