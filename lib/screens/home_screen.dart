import 'package:filter_app/bloc/filter_bloc.dart';
import 'package:filter_app/core/color.dart';
import 'package:filter_app/core/constants.dart';
import 'package:filter_app/screens/details_screen.dart';
import 'package:filter_app/widgets/date_filter_widget.dart';
import 'package:filter_app/widgets/date_picker_widget.dart';
import 'package:filter_app/widgets/search_text_field_widget.dart';
import 'package:filter_app/widgets/search_type_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorsManager.oliveGreenColor,
        title: Text(
          'Home',
          style: TextStyle(
              color: ColorsManager.whiteColor, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<FilterBloc, FilterState>(
          builder: (context, state) {
            return Column(
              children: [
                _buildSearchFilterCard(context),
                kSizedBox25,
                if (state.isFiltered)
                  DetailsScreen(filteredData: state.filteredData),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchFilterCard(BuildContext context) {
    return Card(
      color: ColorsManager.whiteColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: ColorsManager.oliveGreenColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DatePickerWidget(
                    label: 'From',
                    selectedDate: context.read<FilterBloc>().state.fromDate,
                    onDateSelected: (date) =>
                        context.read<FilterBloc>().add(UpdateFromDate(date)),
                  ),
                ),
                kSizedBoxW2,
                Expanded(
                  flex: 2,
                  child: DatePickerWidget(
                    label: 'To',
                    selectedDate: context.read<FilterBloc>().state.toDate,
                    onDateSelected: (date) =>
                        context.read<FilterBloc>().add(UpdateToDate(date)),
                  ),
                ),
                const DateFilterWidget()
              ],
            ),
            kSizedBox20,
            SearchTypeSelectorWidget(
              selectedSearchType: context.read<FilterBloc>().state.searchType,
              onSearchTypeChanged: (newType) =>
                  context.read<FilterBloc>().add(UpdateSearchType(newType)),
            ),
            kSizedBox20,
            if (context.read<FilterBloc>().state.searchType.isNotEmpty &&
                context.read<FilterBloc>().state.searchType != 'All') ...[
              SearchTextFieldWidget(
                searchQuery: context.read<FilterBloc>().state.searchQuery,
                onSearchQueryChanged: (query) =>
                    context.read<FilterBloc>().add(UpdateSearchQuery(query)),
              ),
              kSizedBox20,
            ],
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () =>
                    context.read<FilterBloc>().add(ToggleFilterData()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.oliveGreenColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                label: Text(
                  'Show',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





