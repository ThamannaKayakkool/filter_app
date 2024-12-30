part of 'filter_bloc.dart';

abstract class FilterState {
  final DateTime? fromDate;
  final DateTime? toDate;
  final Map<String, bool> timePeriods;
  final String searchQuery;
  final String searchType;
  final List<Map<String, dynamic>> filteredData;
  final bool isFiltered;

  const FilterState({
    required this.fromDate,
    required this.toDate,
    required this.timePeriods,
    required this.searchQuery,
    required this.searchType,
    required this.filteredData,
    required this.isFiltered,
  });
}

class InitialState extends FilterState {
  InitialState()
      : super(
    fromDate: null,
    toDate: null,
    timePeriods: {
      'Today': false,
      'This Week': false,
      'Last Week': false,
      'This Month': false,
      'Last Month': false,
      'This Quarter': false,
      'Last Quarter': false,
      'Current Fiscal Year': false,
      'Previous Fiscal Year': false,
    },
    searchQuery: '',
    searchType: '',
    filteredData: [],
    isFiltered: false,
  );
}

class UpdatedState extends FilterState {
  const UpdatedState({
    required super.fromDate,
    required super.toDate,
    required super.timePeriods,
    required super.searchQuery,
    required super.searchType,
    required super.filteredData,
    required super.isFiltered,
  });
}
