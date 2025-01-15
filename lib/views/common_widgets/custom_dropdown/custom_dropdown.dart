// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:muslim_vision/views/common_widgets/custom_dropdown/dropdown/dropdown_bloc.dart';

// class DropdownWidget extends StatelessWidget {
//   final List<String> items;
//   const DropdownWidget({super.key, required this.items});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => DropdownBloc(),
//       child: BlocBuilder<DropdownBloc, DropdownState>(
//         builder: (context, state) {
//           return DropdownButton<String>(
//             value: state.selectedItem == 'Select an item' ? null : state.selectedItem,
//             hint: const Text('Select an item'),
//             items: items.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             onChanged: (newValue) {
//               context.read<DropdownBloc>().add(DropdownItemSelected(newValue!));
//             },
//           );
//         },
//       ),
//     );
//   }
// }
