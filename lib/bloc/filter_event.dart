part of 'filter_bloc.dart';

abstract class FilterEvent {
  const FilterEvent();
}

class UpdateFromDate extends FilterEvent {
  final DateTime date;

  UpdateFromDate(this.date);
}

class UpdateToDate extends FilterEvent {
  final DateTime date;

  UpdateToDate(this.date);
}

class UpdateSearchType extends FilterEvent {
  final String type;

  UpdateSearchType(this.type);
}

class UpdateSearchQuery extends FilterEvent {
  final String query;

  UpdateSearchQuery(this.query);
}

class ToggleFilterData extends FilterEvent {}

class ToggleTimePeriod extends FilterEvent {
  final String period;

  ToggleTimePeriod(this.period);
}

class ApplyDateRange extends FilterEvent {}
