// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:instagram_clone/core/services/media_services.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:iconsax/iconsax.dart';

// class InstagramMediaPicker extends StatefulWidget {
//   const InstagramMediaPicker({super.key});

//   @override
//   State<InstagramMediaPicker> createState() => _InstagramMediaPickerState();
// }

// class _InstagramMediaPickerState extends State<InstagramMediaPicker> {
//   AssetPathEntity? selectedAlbum;
//   List<AssetPathEntity> albumList = [];
//   List<AssetEntity> assetList = [];
//   List<AssetEntity> selectedAssetList = [];
//   @override
//   void initState() {
//     super.initState();
//     MediaServices().loadAlbum(RequestType.common).then((value) {
//       setState(() {
//         albumList = value;
//         selectedAlbum = value.isNotEmpty ? value[0] : null;
//       });
//       if (selectedAlbum != null) {
//         MediaServices().loadAssets(selectedAlbum!).then((value) {
//           setState(() {
//             assetList = value;
//           });
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Select your post '),
//       ),
//       body: Column(
//         children: [
//           Flexible(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 15.w,
//                     vertical: 5.h,
//                   ),
//                   child: Row(
//                     children: [
//                       if (selectedAlbum != null)
//                         Text(selectedAlbum!.name == "Recent"
//                             ? "Gallery"
//                             : selectedAlbum?.name ?? ""),
//                       Padding(
//                         padding: EdgeInsets.only(left: 10.w),
//                         child: const Icon(Iconsax.arrow_down_1),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
