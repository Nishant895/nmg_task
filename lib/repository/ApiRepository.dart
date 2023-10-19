
import 'package:assignment/post/model/post_list_model.dart';
import 'package:assignment/post/model/user_list_model.dart';
import 'package:assignment/post_detail/model/post_detail_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'ApiService.dart';
import 'constants/ApiConstants.dart';


class ApiRepository{

   Future<List<UserListModel>> getUserList(BuildContext context) async {
    try{

      dynamic response = await ApiService().getApiCall(ApiConstants.getUser,context);


      List<UserListModel> model = [];
      response.forEach((element) {
        model.add(UserListModel.fromJson(element));
      });

      return model;

    }catch(e){

      rethrow;

    }
  }

   Future<List<PostListModel?>> getPostList(BuildContext context) async {
     try{

       dynamic response = await ApiService().getApiCall(ApiConstants.getPost,context);

       List<PostListModel> model = [];

       response.forEach((element) {
         model.add(PostListModel.fromJson(element));
       });

       return model;

     }catch(e){

       rethrow;

     }
   }

   Future<PostDetailModel> getPostDetail(String id,BuildContext context) async {
     try{

       dynamic response = await ApiService().getApiCall("${ApiConstants.getPost}/$id",context);


       PostDetailModel model = PostDetailModel.fromJson(response);

       return model;

     }catch(e){

       rethrow;

     }
   }


}