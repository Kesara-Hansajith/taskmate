// import 'package:flutter/material.dart';
// import 'package:taskmate/components/dark_main_button.dart';
// import 'package:taskmate/components/snackbar.dart';
// import 'package:taskmate/constants.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// class Reviews extends StatefulWidget {
//   const Reviews({super.key});
//
//   @override
//   State<Reviews> createState() => _ReviewsState();
// }
//
// class _ReviewsState extends State<Reviews> {
//   final _formKey = GlobalKey<FormState>();
//   //Variable for star count
//   int _starRating = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     final reviewFieldController = TextEditingController();
//
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: SizedBox(
//           width: screenWidth,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 24.0),
//                 child: Text(
//                   'Write Your Review',
//                   style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
//                 ),
//               ),
//               Form(
//                 key: _formKey,
//                 child: TextFormField(
//                   controller: reviewFieldController,
//                   maxLines: 6,
//                   decoration: InputDecoration(
//                     hintText: 'Write a review about your Client.',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         width: 1.0,
//                         color: kDarkGreyColor,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(
//                         width: 1.0,
//                         color: kDeepBlueColor,
//                       ),
//                     ),
//                     filled: true,
//                   ),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Field can\'t be empty';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 24.0),
//                 child: Text(
//                   'Rate with Stars!',
//                   style: kJobCardTitleTextStyle.copyWith(color: kJetBlack),
//                 ),
//               ),
//               Center(
//                 child: Column(
//                   children: <Widget>[
//                     RatingBar.builder(
//                       initialRating: 0,
//                       minRating: 1,
//                       direction: Axis.horizontal,
//                       allowHalfRating: false,
//                       itemCount: 5,
//                       itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//                       itemBuilder: (context, _) => const Icon(
//                         Icons.star,
//                         color: Colors.amber,
//                       ),
//                       onRatingUpdate: (rating) {
//                         setState(() {
//                           _starRating = rating.toInt();
//                         });
//                       },
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Text(
//                         (_starRating == 1
//                             ? 'You offered $_starRating Star!'
//                             : 'You offered $_starRating Stars!'),
//                         style: kJobCardTitleTextStyle,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 30.0,
//               ),
//               DarkMainButton(
//                   title: 'Submit Review',
//                   process: () {
//                     if (_formKey.currentState!.validate()) {}
//                     if (_starRating == 0) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         CustomSnackBar('Please rate the user with stars.'),
//                       );
//                     } else {}
//                     //TODO Submit review functionality
//                   },
//                   screenWidth: screenWidth)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
