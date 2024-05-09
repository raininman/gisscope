class Polyline {
	List<Results>? results;
	Properties? properties;

	Polyline({this.results, this.properties});

	Polyline.fromJson(Map<String, dynamic> json) {
		if (json['results'] != null) {
			results = <Results>[];
			json['results'].forEach((v) { results!.add(new Results.fromJson(v)); });
		}
		properties = json['properties'] != null ? new Properties.fromJson(json['properties']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
		if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
		return data;
	}
}

class Results {
	String? mode;
	List<Waypoints>? waypoints;
	String? units;
	int? distance;
	String? distanceUnits;
	List<Legs>? legs;
	List<List>? geometry;

	Results({this.mode, this.waypoints, this.units, this.distance, this.distanceUnits, this.legs, this.geometry});

	Results.fromJson(Map<String, dynamic> json) {
		mode = json['mode'];
		if (json['waypoints'] != null) {
			waypoints = <Waypoints>[];
			json['waypoints'].forEach((v) { waypoints!.add(new Waypoints.fromJson(v)); });
		}
		units = json['units'];
		distance = json['distance'];
		distanceUnits = json['distance_units'];
		if (json['legs'] != null) {
			legs = <Legs>[];
			json['legs'].forEach((v) { legs!.add(new Legs.fromJson(v)); });
		}
		if (json['geometry'] != null) {
			geometry = <List>[];
			json['geometry'].forEach((v) { geometry!.add(v); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['mode'] = this.mode;
		if (this.waypoints != null) {
      data['waypoints'] = this.waypoints!.map((v) => v.toJson()).toList();
    }
		data['units'] = this.units;
		data['distance'] = this.distance;
		data['distance_units'] = this.distanceUnits;
		if (this.legs != null) {
      data['legs'] = this.legs!.map((v) => v.toJson()).toList();
    }
		if (this.geometry != null) {
      data['geometry'] = this.geometry!.toList();
    }
		return data;
	}
}


class Legs {
	int? distance;
	List<Steps>? steps;

	Legs({this.distance, this.steps});

	Legs.fromJson(Map<String, dynamic> json) {
		distance = json['distance'];
		if (json['steps'] != null) {
			steps = <Steps>[];
			json['steps'].forEach((v) { steps!.add(new Steps.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['distance'] = this.distance;
		if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Steps {
	int? fromIndex;
	int? toIndex;
	int? distance;
	Instruction? instruction;

	Steps({this.fromIndex, this.toIndex, this.distance, this.instruction});

	Steps.fromJson(Map<String, dynamic> json) {
		fromIndex = json['from_index'];
		toIndex = json['to_index'];
		distance = json['distance'];
		instruction = json['instruction'] != null ? new Instruction.fromJson(json['instruction']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['from_index'] = this.fromIndex;
		data['to_index'] = this.toIndex;
		data['distance'] = this.distance;
		if (this.instruction != null) {
      data['instruction'] = this.instruction!.toJson();
    }
		return data;
	}
}

class Instruction {
	String? text;

	Instruction({this.text});

	Instruction.fromJson(Map<String, dynamic> json) {
		text = json['text'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['text'] = this.text;
		return data;
	}
}

class Properties {
	String? mode;
	List<Waypoints>? waypoints;
	String? units;

	Properties({this.mode, this.waypoints, this.units});

	Properties.fromJson(Map<String, dynamic> json) {
		mode = json['mode'];
		if (json['waypoints'] != null) {
			waypoints = <Waypoints>[];
			json['waypoints'].forEach((v) { waypoints!.add(new Waypoints.fromJson(v)); });
		}
		units = json['units'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['mode'] = this.mode;
		if (this.waypoints != null) {
      data['waypoints'] = this.waypoints!.map((v) => v.toJson()).toList();
    }
		data['units'] = this.units;
		return data;
	}
}

class Waypoints {
	double? lat;
	double? lon;

	Waypoints({this.lat, this.lon});

	Waypoints.fromJson(Map<String, dynamic> json) {
		lat = json['lat'];
		lon = json['lon'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['lat'] = this.lat;
		data['lon'] = this.lon;
		return data;
	}
}
