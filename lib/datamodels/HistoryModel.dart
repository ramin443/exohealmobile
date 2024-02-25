class HistoryModel{
  int? _id;
  String? _image;
  String? _exercisetype;
  String? _duration;
  String? _date;
  String? _time;

  HistoryModel(this._exercisetype,this._image,this._duration,this._date,this._time);

  int? get id => _id;
  String? get exercisetype => _exercisetype;
  String? get image => _image;
  String? get duration => _duration;
  String? get date => _date;
  String? get time => _time;


  set exercisetype(String? newexercisetype) {
  this._exercisetype = newexercisetype;
  }
  set image(String? newimage) {
    this._image = newimage;
  }
  set duration(String? newduration) {
    this._duration = newduration;
  }
  set date(String? newdate) {
    this._date = newdate;
  }
  set time(String? newtime) {
    this._time = newtime;
  }

  Map<String, dynamic> toMap() {
  var map = Map<String, dynamic>();
  if (id != null) {
  map['id'] = _id;
  }
  map['exercisetype'] = _exercisetype;
  map['image'] = _image;
  map['duration'] = _duration;
  map['date'] = _date;
  map['time'] = _time;


  return map;
  }

  // Extract a Note object from a Map object
  HistoryModel.fromMapObject(Map<String, dynamic> map) {
  this._id = map['id'];
  this._exercisetype = map['exercisetype'];
  this._image = map['image'];
  this._duration = map['duration'];
  this._date = map['date'];
  this._time = map['time'];

  }

  }
