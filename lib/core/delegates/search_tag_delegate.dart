// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:nijimas/widgets/common/error_text.dart';
// import 'package:nijimas/widgets/common/loader.dart';
// import 'package:routemaster/routemaster.dart';

// class SearchCommunityDelegate extends SearchDelegate {
//   final WidgetRef ref;
//   SearchCommunityDelegate({required this.ref});

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             query = "";
//           },
//           icon: const Icon(Icons.close))
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return null;
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return const SizedBox();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return ref.watch(searchCommunityProvider(query)).when(
//         data: (communities) => ListView.builder(
//               itemCount: communities.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final community = communities[index];
//                 return ListTile(
//                     leading: CircleAvatar(
//                         backgroundImage: NetworkImage(community.avatar)),
//                     title: Text("r/${community.name}"),
//                     onTap: () {});
//               },
//             ),
//         error: (error, stacktrace) => ErrorText(error: error.toString()),
//         loading: () => const Loader());
//   }
// }
