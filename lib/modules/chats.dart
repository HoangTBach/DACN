import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chat_room.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache/cache_helper.dart';
import 'package:social_app/shared/network/local/cubit/cubit.dart';
import 'package:social_app/shared/network/local/cubit/cubit_states.dart';
import 'package:social_app/shared/style/colors.dart';

class Chats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: ConditionalBuilder(
              condition: cubit.myConnections.length != 0,
              builder: (context) => ConditionalBuilder(
                condition: state is! GetAllUsersLoadingState,
                builder: (context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 15.h,),

                      // Search for chats
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.sp),
                            boxShadow: [
                              BoxShadow(
                                color: cubit.isDark ? Colors.transparent : Colors.grey.shade400,
                                blurRadius: 7,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            maxLines: 1,
                            onChanged: (value) {
                              cubit.changeNameChat(value);
                            },
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: cubit.isDark ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              // This is giving me the responsive property,
                              // based on text and Icon size
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.sp),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                color: cubit.isDark ? Colors.white : Colors.black,
                              ),
                              filled: true,
                              fillColor: cubit.isDark ? DarkSurface : Colors.white,
                              prefixIcon: Icon(CupertinoIcons.search, size: 20.sp, color: cubit.isDark ? Colors.white : Colors.black,),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 15.h,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: cubit.isDark ? DarkSurface : Colors.white,
                            borderRadius: BorderRadius.circular(13.sp),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('users')
                              .doc(CacheHelper.getData('userId'))
                              .collection('connections')
                              .snapshots(),

                            builder: (context, snapshot) {
                              return (snapshot.connectionState == ConnectionState.waiting)
                              ? Center(
                                child: CircularProgressIndicator(
                                  color: blue, strokeWidth: 3.sp,),
                              ) :
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> doc = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

                                  return FutureBuilder(
                                    future: doc['user'].get(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData)
                                        {
                                          DocumentSnapshot ss = snapshot.data as DocumentSnapshot ;

                                          UserModel user = UserModel.fromJson(ss.data() as Map<String, dynamic>);

                                          if(cubit.nameChat.isEmpty)
                                            return chatItemBuilder(user, context, cubit);
                                          if(user.name.toLowerCase().startsWith(cubit.nameChat.toLowerCase()))
                                            return chatItemBuilder(user, context, cubit);

                                          return Container();
                                        }
                                      else
                                        {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: blue,
                                              strokeWidth: 3.sp,
                                            ),
                                          );
                                        }
                                    },
                                  );

                                },
                                separatorBuilder:(context, index) => separator(context),
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                              );
                            }
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h,),
                    ],
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator(color: blue,),),
              ),
              fallback: (context) => Center(
                child: Text(
                  'No Users.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget chatItemBuilder(UserModel user, BuildContext context, AppCubit cubit) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(13.5.sp),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              PageTransition(type: PageTransitionType.rightToLeft,
                  child: ChatRoom(user)));
        },
        splashColor: cubit.isDark ? Colors.grey.shade800 : Colors.grey.shade50,
        highlightColor: cubit.isDark ? Colors.grey.shade800 : Colors.grey.shade50,
        child: Container(
          padding: EdgeInsets.all(12.5.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: cubit.isDark ? DarkBackground : superBabyBlue,
                radius: 30.sp,
                backgroundImage: NetworkImage(user.image),
              ),
              SizedBox(
                width: 15.w,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: cubit.isDark ? Colors.white : Colors.black,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      user.bio,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.5.sp,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
