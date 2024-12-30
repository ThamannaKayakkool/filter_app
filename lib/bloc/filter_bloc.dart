import 'package:filter_app/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filter_event.dart';

part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(InitialState()) {
    on<UpdateFromDate>((event, emit) {
      emit(UpdatedState(
        fromDate: event.date,
        toDate: state.toDate,
        timePeriods: state.timePeriods,
        searchQuery: state.searchQuery,
        searchType: state.searchType,
        filteredData: state.filteredData,
        isFiltered: state.isFiltered,
      ));
    });

    on<UpdateToDate>((event, emit) {
      emit(UpdatedState(
        fromDate: state.fromDate,
        toDate: event.date,
        timePeriods: state.timePeriods,
        searchQuery: state.searchQuery,
        searchType: state.searchType,
        filteredData: state.filteredData,
        isFiltered: state.isFiltered,
      ));
    });

    on<UpdateSearchType>((event, emit) {
      emit(UpdatedState(
        fromDate: state.fromDate,
        toDate: state.toDate,
        timePeriods: state.timePeriods,
        searchQuery: '',
        searchType: event.type,
        filteredData: state.filteredData,
        isFiltered: state.isFiltered,
      ));
    });

    on<UpdateSearchQuery>((event, emit) {
      emit(UpdatedState(
        fromDate: state.fromDate,
        toDate: state.toDate,
        timePeriods: state.timePeriods,
        searchQuery: event.query,
        searchType: state.searchType,
        filteredData: state.filteredData,
        isFiltered: state.isFiltered,
      ));
    });

    on<ToggleFilterData>((event, emit) {
      final newState = UpdatedState(
        fromDate: state.fromDate,
        toDate: state.toDate,
        timePeriods: state.timePeriods,
        searchQuery: state.searchQuery,
        searchType: state.searchType,
        filteredData: state.filteredData,
        isFiltered: !state.isFiltered,
      );

      if (newState.isFiltered) {
        _filterData(newState, emit);
      } else {
        emit(newState);
      }
    });
    on<ToggleTimePeriod>((event, emit) {
      final newState = Map<String, bool>.from(state.timePeriods)..[event.period] = !state.timePeriods[event.period]!;
      emit(UpdatedState(
        fromDate: state.fromDate,
        toDate: state.toDate,
        timePeriods: newState,
        searchQuery: state.searchQuery,
        searchType: state.searchType,
        filteredData: state.filteredData,
        isFiltered: state.isFiltered,
      ));
    });

    on<ApplyDateRange>((event, emit) {
      final now = DateTime.now();
      DateTime? fromDate, toDate;

      for (final period in state.timePeriods.entries) {
        if (period.value) {
          if (period.key == 'Today') {
            fromDate = now;
            toDate = now;
          } else if (period.key == 'This Week') {
            fromDate = now.subtract(Duration(days: now.weekday - 1));
            toDate = now.add(Duration(days: 7 - now.weekday));
          } else if (period.key == 'Last Week') {
            final startOfThisWeek = now.subtract(Duration(days: now.weekday - 1));
            fromDate = startOfThisWeek.subtract(const Duration(days: 7));
            toDate = startOfThisWeek.subtract(const Duration(days: 1));
          } else if (period.key == 'This Month') {
            fromDate = DateTime(now.year, now.month, 1);
            toDate = DateTime(now.year, now.month + 1, 0);
          } else if (period.key == 'Last Month') {
            final lastMonth = DateTime(now.year, now.month - 1, 1);
            fromDate = lastMonth;
            toDate = DateTime(lastMonth.year, lastMonth.month + 1, 0);
          } else if (period.key == 'This Quarter') {
            final quarterStartMonth = ((now.month - 1) ~/ 3) * 3 + 1;
            fromDate = DateTime(now.year, quarterStartMonth, 1);
            toDate = DateTime(now.year, quarterStartMonth + 3, 0);
          } else if (period.key == 'Last Quarter') {
            final currentQuarter = ((now.month - 1) ~/ 3) * 3 + 1;
            final lastQuarterStartMonth = currentQuarter - 3;
            fromDate = DateTime(now.year, lastQuarterStartMonth, 1);
            toDate = DateTime(now.year, lastQuarterStartMonth + 3, 0);
          } else if (period.key == 'Current Fiscal Year') {
            fromDate = DateTime(now.year, 4, 1);
            toDate = DateTime(now.year + 1, 3, 31);
          } else if (period.key == 'Previous Fiscal Year') {
            fromDate = DateTime(now.year - 1, 4, 1);
            toDate = DateTime(now.year, 3, 31);
          }
        }
      }

      emit(UpdatedState(
        fromDate: fromDate,
        toDate: toDate,
        timePeriods: state.timePeriods,
        searchQuery: state.searchQuery,
        searchType: state.searchType,
        filteredData: state.filteredData,
        isFiltered: state.isFiltered,
      ));
    });

  }
  void _filterData(FilterState state, Emitter<FilterState> emit) {
    final filteredData = customerData.entries
        .where((entry) {
      final data = entry.value as Map<String, dynamic>;
      final matchesType = (state.searchType == 'Customer Name' &&
          entry.key.toLowerCase().contains(state.searchQuery.toLowerCase())) ||
          (state.searchType == 'Mobile Number' &&
              data['mobile']
                  .toString()
                  .contains(state.searchQuery)) ||
          (state.searchType == 'PurchaseCode' &&
              data['purchaseCode']
                  .toString()
                  .toLowerCase()
                  .contains(state.searchQuery.toLowerCase())) ||
          (state.searchType == 'PaymentType' &&
              data['paymentType']
                  .toString()
                  .toLowerCase()
                  .contains(state.searchQuery.toLowerCase())) ||
          (state.searchType == 'All' &&
              (entry.key.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
                  data['mobile']
                      .toString()
                      .contains(state.searchQuery) ||
                  data['purchaseCode']
                      .toString()
                      .toLowerCase()
                      .contains(state.searchQuery.toLowerCase()) ||
                  data['paymentType']
                      .toString()
                      .toLowerCase()
                      .contains(state.searchQuery.toLowerCase())));

      final matchesDate = (state.fromDate == null ||
          (data['date'] as DateTime).isAfter(state.fromDate!)) &&
          (state.toDate == null ||
              (data['date'] as DateTime).isBefore(state.toDate!));

      return matchesType && matchesDate;
    })
        .map((entry) => {
      'name': entry.key,
      ...entry.value as Map<String, dynamic>,
    })
        .toList();

    emit(UpdatedState(
      fromDate: state.fromDate,
      toDate: state.toDate,
      timePeriods: state.timePeriods,
      searchQuery: state.searchQuery,
      searchType: state.searchType,
      filteredData: filteredData,
      isFiltered: true,
    ));
  }

}
