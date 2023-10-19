
import 'package:assignment/post/model/post_list_model.dart';
import 'package:assignment/post/model/user_list_model.dart';
import 'package:assignment/post/view_model/post_view_model.dart';
import 'package:assignment/post_detail/view/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repository/api_response.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({Key? key}) : super(key: key);

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {

  @override
  void initState() {
    getAutherList();
    super.initState();
  }

  getAutherList() async{

    await Provider.of<PostViewModel>(context, listen: false).getAutherList(context);

  }


  @override
  Widget build(BuildContext context) {

    ApiResponse apiResponse = Provider.of<PostViewModel>(context).response;


    print(apiResponse.status);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
      ),
      body: postListWidget(apiResponse),
    );
  }


  Widget postListWidget(ApiResponse apiResponse){

    switch (apiResponse.status) {
      case Status.LOADING:

        return const Center(
          child: CircularProgressIndicator(),
        );


      case Status.COMPLETED :

        List<UserListModel?>  userListModel =  Provider.of<PostViewModel>(context).getUserListModel;

        List<PostListModel?>  postListModel =  Provider.of<PostViewModel>(context).getPostListModel;

        var username = "";
        Map usermap = {};



        for(int i  = 0; i< userListModel.length ; i++){
          usermap[userListModel[i]?.id] = userListModel[i]!.name;
        }



        return Container(
          color: Colors.white,
          child:    ListView.builder(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            itemCount: postListModel.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index){
              return
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                  child: GestureDetector(
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child :  Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(postListModel[index]!.title.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                              SizedBox(height: 10,),
                              Text(postListModel[index]!.body.toString(),
                                style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black),),
                              SizedBox(height: 10,),
                              Text("Auther Name : "+usermap[postListModel[index]!.userId],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                            ],
                          ),
                        )
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostDetailScreen(postListModel[index]!.id!)));
                    },
                  ),
                );
            },
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
