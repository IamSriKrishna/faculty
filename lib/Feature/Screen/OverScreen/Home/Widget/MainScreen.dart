import 'package:faculty/Feature/Service/AddPostService.dart';
import 'package:faculty/Provider/FacultyProvider.dart';
import 'package:faculty/Util/Additional/Loader.dart';
import 'package:faculty/model/post.dart';
import 'package:flutter/material.dart';
import 'package:faculty/Feature/Screen/OverScreen/Home/Widget/Additional/PostCard.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const route = '/MainScreen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Post>? fetchpost;

  final AddPostService _postService = AddPostService();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    fetchpost = await _postService.DisplayAllForm(context:context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final faculty = Provider.of<FacultyProvider>(context).user;
    return fetchpost == null
        ? const Loader()
        :Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0),
                    child: ListView.builder(
                      itemCount: 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(faculty.dp))
                              ),
                            ),
                            Text(faculty.name)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 20,
                  left: 45,
                  child: Icon(
                    Icons.add,size: 25,color: Colors.amberAccent,
                  )
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (fetchpost == null) {
                  // Handle the case when post is null, e.g., show a loading indicator or an error message.
                  return Center(child: CircularProgressIndicator()); // Replace with your preferred loading widget.
                }
                
                final reversedIndex = fetchpost!.length - 1 - index;
                final productData = fetchpost![reversedIndex];
                return PostCard(
                  title: productData.title, 
                  dp: productData.dp, 
                  images: productData.image_url,
                  description: productData.description, 
                  likes: productData.likes, 
                  link: productData.link, 
                  name: productData.name
                ); // Replace with your logic for rendering a Post card.
              },
              childCount: fetchpost?.length ?? 0, // Provide a default count of 0 when post is null.
              
            ),
          ),
        ],
      ),
    );
  }
}
