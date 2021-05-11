import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../const.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 65.0.w,
          height: 6.0.h,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'What you are looking for',
                hintStyle: TextStyle(
                  fontSize: 11.0.sp,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          width: 20.0.w,
          height: 6.0.h,
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              )),
          child: Center(
            child: Icon(Icons.search, color: kWhiteColor),
          ),
        ),
      ],
    );
  }
}
