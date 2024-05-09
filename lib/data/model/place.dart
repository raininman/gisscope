class Place {
  String? type;
  List<Features>? features;

  Place({this.type, this.features});

  Place.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  String? type;
  Properties? properties;
  Geometry? geometry;

  Features({this.type, this.properties, this.geometry});

  Features.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    return data;
  }
}

class Properties {
  String? country;
  String? countryCode;
  String? city;
  String? postcode;
  String? district;
  String? suburb;
  String? street;
  double? lon;
  double? lat;
  String? formatted;
  String? addressLine1;
  String? addressLine2;
  List<String>? categories;
  List<String>? details;
  Datasource? datasource;
  Commercial? commercial;
  int? distance;
  String? placeId;
  String? name;
  String? housenumber;
  String? website;
  String? openingHours;
  NameInternational? nameInternational;
  // Contact? contact;
  String? neighbourhood;
  String? brand;
  BrandDetails? brandDetails;
  String? operator;
  PaymentOptions? paymentOptions;
  Building? building;
  String? description;
  Facilities? facilities;

  Properties(
      {this.country,
      this.countryCode,
      this.city,
      this.postcode,
      this.district,
      this.suburb,
      this.street,
      this.lon,
      this.lat,
      this.formatted,
      this.addressLine1,
      this.addressLine2,
      this.categories,
      this.details,
      this.datasource,
      this.commercial,
      this.distance,
      this.placeId,
      this.name,
      this.housenumber,
      this.website,
      this.openingHours,
      this.nameInternational,
      // this.contact,
      this.neighbourhood,
      this.brand,
      this.brandDetails,
      this.operator,
      this.paymentOptions,
      this.building,
      this.description,
      this.facilities});

  Properties.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    countryCode = json['country_code'];
    city = json['city'];
    postcode = json['postcode'];
    district = json['district'];
    suburb = json['suburb'];
    street = json['street'];
    lon = json['lon'];
    lat = json['lat'];
    formatted = json['formatted'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    categories = json['categories'].cast<String>();
    details = json['details'].cast<String>();
    datasource = json['datasource'] != null
        ? new Datasource.fromJson(json['datasource'])
        : null;
    commercial = json['commercial'] != null
        ? new Commercial.fromJson(json['commercial'])
        : null;
    distance = json['distance'];
    placeId = json['place_id'];
    name = json['name'];
    housenumber = json['housenumber'];
    website = json['website'];
    openingHours = json['opening_hours'];
    nameInternational = json['name_international'] != null
        ? new NameInternational.fromJson(json['name_international'])
        : null;
    // contact =
    //     json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    neighbourhood = json['neighbourhood'];
    brand = json['brand'];
    brandDetails = json['brand_details'] != null
        ? new BrandDetails.fromJson(json['brand_details'])
        : null;
    operator = json['operator'];
    paymentOptions = json['payment_options'] != null
        ? new PaymentOptions.fromJson(json['payment_options'])
        : null;
    building = json['building'] != null
        ? new Building.fromJson(json['building'])
        : null;
    description = json['description'];
    facilities = json['facilities'] != null
        ? new Facilities.fromJson(json['facilities'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['district'] = this.district;
    data['suburb'] = this.suburb;
    data['street'] = this.street;
    data['lon'] = this.lon;
    data['lat'] = this.lat;
    data['formatted'] = this.formatted;
    data['address_line1'] = this.addressLine1;
    data['address_line2'] = this.addressLine2;
    data['categories'] = this.categories;
    data['details'] = this.details;
    if (this.datasource != null) {
      data['datasource'] = this.datasource!.toJson();
    }
    if (this.commercial != null) {
      data['commercial'] = this.commercial!.toJson();
    }
    data['distance'] = this.distance;
    data['place_id'] = this.placeId;
    data['name'] = this.name;
    data['housenumber'] = this.housenumber;
    data['website'] = this.website;
    data['opening_hours'] = this.openingHours;
    if (this.nameInternational != null) {
      data['name_international'] = this.nameInternational!.toJson();
    }
    // if (this.contact != null) {
    //   data['contact'] = this.contact!.toJson();
    // }
    data['neighbourhood'] = this.neighbourhood;
    data['brand'] = this.brand;
    if (this.brandDetails != null) {
      data['brand_details'] = this.brandDetails!.toJson();
    }
    data['operator'] = this.operator;
    if (this.paymentOptions != null) {
      data['payment_options'] = this.paymentOptions!.toJson();
    }
    if (this.building != null) {
      data['building'] = this.building!.toJson();
    }
    data['description'] = this.description;
    if (this.facilities != null) {
      data['facilities'] = this.facilities!.toJson();
    }
    return data;
  }
}

class Datasource {
  String? sourcename;
  String? attribution;
  String? license;
  String? url;
  Raw? raw;

  Datasource(
      {this.sourcename, this.attribution, this.license, this.url, this.raw});

  Datasource.fromJson(Map<String, dynamic> json) {
    sourcename = json['sourcename'];
    attribution = json['attribution'];
    license = json['license'];
    url = json['url'];
    // raw = json['raw'] != null ? new Raw.fromJson(json['raw']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourcename'] = this.sourcename;
    data['attribution'] = this.attribution;
    data['license'] = this.license;
    data['url'] = this.url;
    if (this.raw != null) {
      data['raw'] = this.raw!.toJson();
    }
    return data;
  }
}

class Raw {
  String? shop;
  int? osmId;
  String? osmType;
  String? name;
  String? phone;
  String? nameBe;
  String? nameRu;
  String? nameUk;
  String? website;
  String? addrCity;
  String? addrStreet;
  String? addrCityRu;
  String? addrCountry;
  String? openingHours;
  int? addrHousenumber;
  String? brand;
  String? amenity;
  String? nameEn;
  String? brandBe;
  String? brandEn;
  String? brandRu;
  String? operator;
  String? contactVk;
  String? contactEmail;
  int? contactPhone;
  String? brandWikidata;
  String? contactWebsite;
  String? contactFacebook;
  String? contactInstagram;
  String? contactYoutube;
  String? paymentCash;
  int? addrPostcode;
  String? paymentDebitCards;
  String? paymentCreditCards;
  String? building;
  String? roofShape;
  String? roofColour;
  int? level;
  String? contactOk;
  String? wheelchair;
  String? description;
  String? checkDate;
  String? paymentVisa;
  String? paymentMastercard;
  String? paymentMaestro;
  String? checkDateOpeningHours;
  String? toilets;
  String? buildingColour;
  int? buildingLevels;
  String? email;
  String? operatorBe;
  String? operatorRu;

  Raw(
      {this.shop,
      this.osmId,
      this.osmType,
      this.name,
      this.phone,
      this.nameBe,
      this.nameRu,
      this.nameUk,
      this.website,
      this.addrCity,
      this.addrStreet,
      this.addrCityRu,
      this.addrCountry,
      this.openingHours,
      this.addrHousenumber,
      this.brand,
      this.amenity,
      this.nameEn,
      this.brandBe,
      this.brandEn,
      this.brandRu,
      this.operator,
      this.contactVk,
      this.contactEmail,
      this.contactPhone,
      this.brandWikidata,
      this.contactWebsite,
      this.contactFacebook,
      this.contactInstagram,
      this.contactYoutube,
      this.paymentCash,
      this.addrPostcode,
      this.paymentDebitCards,
      this.paymentCreditCards,
      this.building,
      this.roofShape,
      this.roofColour,
      this.level,
      this.contactOk,
      this.wheelchair,
      this.description,
      this.checkDate,
      this.paymentVisa,
      this.paymentMastercard,
      this.paymentMaestro,
      this.checkDateOpeningHours,
      this.toilets,
      this.buildingColour,
      this.buildingLevels,
      this.email,
      this.operatorBe,
      this.operatorRu});

  Raw.fromJson(Map<String, dynamic> json) {
    shop = json['shop'];
    osmId = json['osm_id'];
    osmType = json['osm_type'];
    name = json['name'];
    phone = json['phone'];
    nameBe = json['name:be'];
    nameRu = json['name:ru'];
    nameUk = json['name:uk'];
    website = json['website'];
    addrCity = json['addr:city'];
    addrStreet = json['addr:street'];
    addrCityRu = json['addr:city:ru'];
    addrCountry = json['addr:country'];
    openingHours = json['opening_hours'];
    addrHousenumber = json['addr:housenumber'];
    brand = json['brand'];
    amenity = json['amenity'];
    nameEn = json['name:en'];
    brandBe = json['brand:be'];
    brandEn = json['brand:en'];
    brandRu = json['brand:ru'];
    operator = json['operator'];
    contactVk = json['contact:vk'];
    contactEmail = json['contact:email'];
    contactPhone = json['contact:phone'];
    brandWikidata = json['brand:wikidata'];
    contactWebsite = json['contact:website'];
    contactFacebook = json['contact:facebook'];
    contactInstagram = json['contact:instagram'];
    contactYoutube = json['contact:youtube'];
    paymentCash = json['payment:cash'];
    addrPostcode = json['addr:postcode'];
    paymentDebitCards = json['payment:debit_cards'];
    paymentCreditCards = json['payment:credit_cards'];
    building = json['building'];
    roofShape = json['roof:shape'];
    roofColour = json['roof:colour'];
    level = json['level'];
    contactOk = json['contact:ok'];
    wheelchair = json['wheelchair'];
    description = json['description'];
    checkDate = json['check_date'];
    paymentVisa = json['payment:visa'];
    paymentMastercard = json['payment:mastercard'];
    paymentMaestro = json['payment:maestro'];
    checkDateOpeningHours = json['check_date:opening_hours'];
    toilets = json['toilets'];
    buildingColour = json['building:colour'];
    buildingLevels = json['building:levels'];
    email = json['email'];
    operatorBe = json['operator:be'];
    operatorRu = json['operator:ru'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop'] = this.shop;
    data['osm_id'] = this.osmId;
    data['osm_type'] = this.osmType;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['name:be'] = this.nameBe;
    data['name:ru'] = this.nameRu;
    data['name:uk'] = this.nameUk;
    data['website'] = this.website;
    data['addr:city'] = this.addrCity;
    data['addr:street'] = this.addrStreet;
    data['addr:city:ru'] = this.addrCityRu;
    data['addr:country'] = this.addrCountry;
    data['opening_hours'] = this.openingHours;
    data['addr:housenumber'] = this.addrHousenumber;
    data['brand'] = this.brand;
    data['amenity'] = this.amenity;
    data['name:en'] = this.nameEn;
    data['brand:be'] = this.brandBe;
    data['brand:en'] = this.brandEn;
    data['brand:ru'] = this.brandRu;
    data['operator'] = this.operator;
    data['contact:vk'] = this.contactVk;
    data['contact:email'] = this.contactEmail;
    data['contact:phone'] = this.contactPhone;
    data['brand:wikidata'] = this.brandWikidata;
    data['contact:website'] = this.contactWebsite;
    data['contact:facebook'] = this.contactFacebook;
    data['contact:instagram'] = this.contactInstagram;
    data['contact:youtube'] = this.contactYoutube;
    data['payment:cash'] = this.paymentCash;
    data['addr:postcode'] = this.addrPostcode;
    data['payment:debit_cards'] = this.paymentDebitCards;
    data['payment:credit_cards'] = this.paymentCreditCards;
    data['building'] = this.building;
    data['roof:shape'] = this.roofShape;
    data['roof:colour'] = this.roofColour;
    data['level'] = this.level;
    data['contact:ok'] = this.contactOk;
    data['wheelchair'] = this.wheelchair;
    data['description'] = this.description;
    data['check_date'] = this.checkDate;
    data['payment:visa'] = this.paymentVisa;
    data['payment:mastercard'] = this.paymentMastercard;
    data['payment:maestro'] = this.paymentMaestro;
    data['check_date:opening_hours'] = this.checkDateOpeningHours;
    data['toilets'] = this.toilets;
    data['building:colour'] = this.buildingColour;
    data['building:levels'] = this.buildingLevels;
    data['email'] = this.email;
    data['operator:be'] = this.operatorBe;
    data['operator:ru'] = this.operatorRu;
    return data;
  }
}

class Commercial {
  String? type;
  int? level;

  Commercial({this.type, this.level});

  Commercial.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['level'] = this.level;
    return data;
  }
}

class NameInternational {
  String? be;
  String? ru;
  String? uk;
  String? en;

  NameInternational({this.be, this.ru, this.uk, this.en});

  NameInternational.fromJson(Map<String, dynamic> json) {
    be = json['be'];
    ru = json['ru'];
    uk = json['uk'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['be'] = this.be;
    data['ru'] = this.ru;
    data['uk'] = this.uk;
    data['en'] = this.en;
    return data;
  }
}

class Contact {
  String? phone;
  String? email;

  Contact({this.phone, this.email});

  Contact.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}

class BrandDetails {
  String? wikidata;

  BrandDetails({this.wikidata});

  BrandDetails.fromJson(Map<String, dynamic> json) {
    wikidata = json['wikidata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wikidata'] = this.wikidata;
    return data;
  }
}

class PaymentOptions {
  bool? cash;
  bool? debitCards;
  bool? creditCards;
  bool? visa;
  bool? mastercard;
  bool? maestro;

  PaymentOptions(
      {this.cash,
      this.debitCards,
      this.creditCards,
      this.visa,
      this.mastercard,
      this.maestro});

  PaymentOptions.fromJson(Map<String, dynamic> json) {
    cash = json['cash'];
    debitCards = json['debit_cards'];
    creditCards = json['credit_cards'];
    visa = json['visa'];
    mastercard = json['mastercard'];
    maestro = json['maestro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cash'] = this.cash;
    data['debit_cards'] = this.debitCards;
    data['credit_cards'] = this.creditCards;
    data['visa'] = this.visa;
    data['mastercard'] = this.mastercard;
    data['maestro'] = this.maestro;
    return data;
  }
}

class Building {
  Roof? roof;
  int? levels;
  String? type;
  String? color;

  Building({this.roof, this.levels, this.type, this.color});

  Building.fromJson(Map<String, dynamic> json) {
    roof = json['roof'] != null ? new Roof.fromJson(json['roof']) : null;
    levels = json['levels'];
    type = json['type'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roof != null) {
      data['roof'] = this.roof!.toJson();
    }
    data['levels'] = this.levels;
    data['type'] = this.type;
    data['color'] = this.color;
    return data;
  }
}

class Roof {
  String? shape;
  String? color;

  Roof({this.shape, this.color});

  Roof.fromJson(Map<String, dynamic> json) {
    shape = json['shape'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shape'] = this.shape;
    data['color'] = this.color;
    return data;
  }
}

class Facilities {
  bool? wheelchair;
  bool? toilets;

  Facilities({this.wheelchair, this.toilets});

  Facilities.fromJson(Map<String, dynamic> json) {
    wheelchair = json['wheelchair'];
    toilets = json['toilets'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wheelchair'] = this.wheelchair;
    data['toilets'] = this.toilets;
    return data;
  }
}

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
