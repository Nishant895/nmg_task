
import 'package:assignment/post_detail/model/post_detail_model.dart';
import 'package:assignment/post_detail/view_model/post_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repository/api_response.dart';

class PostDetailScreen extends StatefulWidget {
  int id;
  PostDetailScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {


  @override
  void initState() {
    getPostDetail();
    super.initState();
  }

  getPostDetail() async{

    await Provider.of<PostDetailViewModel>(context, listen: false).getPostDetail(widget.id.toString(),context);

  }


  @override
  Widget build(BuildContext context) {

    ApiResponse apiResponse = Provider.of<PostDetailViewModel>(context).response;


    return Scaffold(
      appBar: AppBar(
        title: const Text("Post detail"),
      ),
      body:postDetailWidget(apiResponse),


    );
  }


  Widget postDetailWidget(ApiResponse apiResponse){

    switch (apiResponse.status) {
      case Status.LOADING:

        return const Center(
          child: CircularProgressIndicator(),
        );


      case Status.COMPLETED :

        PostDetailModel?  postDetailModel =  Provider.of<PostDetailViewModel>(context).getPostDetailModel;

        return Container(
          color: Colors.white,
          child:    Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(postDetailModel!.title.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                      SizedBox(height: 10,),
                      Text(postDetailModel.body.toString(),
                        style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.black),),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );


      case Status.ERROR:
        return const Center(
          child: Text('Please try again latter!!!'),
        );
      case Status.INITIAL:
      default:
        return Container();
    }
  }


}
