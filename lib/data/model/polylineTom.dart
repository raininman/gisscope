class PolylineTom {
  String? formatVersion;
  List<Routes>? routes;

  PolylineTom({this.formatVersion, this.routes});

  PolylineTom.fromJson(Map<String, dynamic> json) {
    formatVersion = json['formatVersion'];
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(new Routes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['formatVersion'] = this.formatVersion;
    if (this.routes != null) {
      data['routes'] = this.routes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routes {
  Summary? summary;
  List<Legs>? legs;
  List<Sections>? sections;

  Routes({this.summary, this.legs, this.sections});

  Routes.fromJson(Map<String, dynamic> json) {
    summary =
        json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    if (json['legs'] != null) {
      legs = <Legs>[];
      json['legs'].forEach((v) {
        legs!.add(new Legs.fromJson(v));
      });
    }
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.legs != null) {
      data['legs'] = this.legs!.map((v) => v.toJson()).toList();
    }
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  int? lengthInMeters;
  int? travelTimeInSeconds;
  int? trafficDelayInSeconds;
  int? trafficLengthInMeters;
  String? departureTime;
  String? arrivalTime;

  Summary(
      {this.lengthInMeters,
      this.travelTimeInSeconds,
      this.trafficDelayInSeconds,
      this.trafficLengthInMeters,
      this.departureTime,
      this.arrivalTime});

  Summary.fromJson(Map<String, dynamic> json) {
    lengthInMeters = json['lengthInMeters'];
    travelTimeInSeconds = json['travelTimeInSeconds'];
    trafficDelayInSeconds = json['trafficDelayInSeconds'];
    trafficLengthInMeters = json['trafficLengthInMeters'];
    departureTime = json['departureTime'];
    arrivalTime = json['arrivalTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lengthInMeters'] = this.lengthInMeters;
    data['travelTimeInSeconds'] = this.travelTimeInSeconds;
    data['trafficDelayInSeconds'] = this.trafficDelayInSeconds;
    data['trafficLengthInMeters'] = this.trafficLengthInMeters;
    data['departureTime'] = this.departureTime;
    data['arrivalTime'] = this.arrivalTime;
    return data;
  }
}

class Legs {
  Summary? summary;
  List<Points>? points;

  Legs({this.summary, this.points});

  Legs.fromJson(Map<String, dynamic> json) {
    summary =
        json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    if (json['points'] != null) {
      points = <Points>[];
      json['points'].forEach((v) {
        points!.add(new Points.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.points != null) {
      data['points'] = this.points!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Points {
  double? latitude;
  double? longitude;

  Points({this.latitude, this.longitude});

  Points.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Sections {
  int? startPointIndex;
  int? endPointIndex;
  String? sectionType;
  String? travelMode;

  Sections(
      {this.startPointIndex,
      this.endPointIndex,
      this.sectionType,
      this.travelMode});

  Sections.fromJson(Map<String, dynamic> json) {
    startPointIndex = json['startPointIndex'];
    endPointIndex = json['endPointIndex'];
    sectionType = json['sectionType'];
    travelMode = json['travelMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startPointIndex'] = this.startPointIndex;
    data['endPointIndex'] = this.endPointIndex;
    data['sectionType'] = this.sectionType;
    data['travelMode'] = this.travelMode;
    return data;
  }
}
