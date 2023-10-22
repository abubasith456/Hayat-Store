// ignore_for_file: empty_statements
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/bloc/news_block/post_bloc.dart';
import 'package:shop_app/models/news_model.dart';
import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc()..add(GetPost()),
      child: BlocConsumer<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostOnError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          } else if (state is PostLoading) {
            shimmerWidget(context);
          }
        },
        builder: (context, state) {
          if (state is PostLoaded) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: state.newsModel.count,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //
                    },
                    child: post(index, context, state.newsModel),
                  );
                },
              ),
            );
          } else {
            return shimmerWidget(context);
          }
        },
      ),
    );
  }
}

Widget post(int index, BuildContext context, PostModel postModel) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage("assets/images/appLogo.png"),
                backgroundColor: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [
                  Text(
                    postModel.posts![index].user!.username!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Text("Some where in earth")
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Image.network(postModel.posts![index].image!),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(children: [
              IconButton(
                  padding: EdgeInsets.fromLTRB(0, 0, 1, 0),
                  constraints: BoxConstraints(),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )),
              SizedBox(width: 8),
              IconButton(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  constraints: BoxConstraints(),
                  onPressed: () {
                    showBottomSheet(context);
                  },
                  icon: Icon(Icons.comment_outlined)),
              SizedBox(
                width: 5,
              ),
              IconButton(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  constraints: BoxConstraints(),
                  onPressed: () {},
                  icon: Icon(Icons.bookmark_outline)),
            ]),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(children: [
              Text((postModel.posts![index].likes!.length.toString() +
                  " Likes")),
            ]),
          ),
        ],
      ),
    ),
  );
}

Widget shimmerWidget(BuildContext context) {
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Card(
          child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(),
        ),
      )));
}

Future showBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Comments",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text("Vanako Mapla"),
                        subtitle: Text("by some one"),
                      ),
                      Divider()
                    ],
                  );
                },
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Add a comment...'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        );
      });
}

// liked == true ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border))