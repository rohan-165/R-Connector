mixin DashMixin {
  String getTotalSurveyCount({required Map<int, dynamic> countMap}) {
    int total = countMap.values.fold<int>(
      0,
      (sum, value) =>
          sum + (value is int ? value : int.tryParse(value.toString()) ?? 0),
    );

    return total.toString();
  }
}
