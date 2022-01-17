int TimeAsSinceEpoch(String time) {
  var parsedTime = DateTime.parse(time).millisecondsSinceEpoch;
  return parsedTime;
}