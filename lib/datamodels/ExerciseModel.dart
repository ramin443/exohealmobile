class ExerciseModel{
  int? _id;
  String? _image;
  String? _exercisetype;
  String? _description;
  String? _duration;


  ExerciseModel(this._image,this._exercisetype,this._description,this._duration);

  int? get id => _id;
  String? get image => _image;
  String? get exercisetype => _exercisetype;
  String? get description => _description;
  String? get duration => _duration;

  set image(String? newimage) {
    this._image = newimage;
  }
  set exercisetype(String? newexercisetype) {
    this._exercisetype = newexercisetype;
  }
  set description(String? newdescription) {
    this._description = newdescription;
  }
  set duration(String? newduration) {
    this._duration = newduration;
  }


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['image'] = _image;
    map['exercisetype'] = _exercisetype;
    map['description'] = _description;
    map['duration'] = _duration;



    return map;
  }

  // Extract a Note object from a Map object
  ExerciseModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._image = map['image'];
    this._exercisetype = map['exercisetype'];
    this._description = map['description'];
    this._duration = map['duration'];

  }

}
