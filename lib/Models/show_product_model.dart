class TmdbModel {
  Collection? collection;

  TmdbModel({
    this.collection,
  });
}

class Collection {
  Info? info;
  List<Item>? item;

  Collection({
    this.info,
    this.item,
  });
}

class Info {
  String? postmanId;
  String? name;
  String? schema;
  DateTime? updatedAt;
  String? uid;
  dynamic createdAt;
  dynamic lastUpdatedBy;

  Info({
    this.postmanId,
    this.name,
    this.schema,
    this.updatedAt,
    this.uid,
    this.createdAt,
    this.lastUpdatedBy,
  });
}

class Item {
  String? name;
  String? id;
  ProtocolProfileBehavior? protocolProfileBehavior;
  Request? request;
  List<dynamic>? response;
  String? uid;

  Item({
    this.name,
    this.id,
    this.protocolProfileBehavior,
    this.request,
    this.response,
    this.uid,
  });
}

class ProtocolProfileBehavior {
  bool? disableBodyPruning;

  ProtocolProfileBehavior({
    this.disableBodyPruning,
  });
}

class Request {
  String? method;
  List<dynamic>? header;
  Url? url;

  Request({
    this.method,
    this.header,
    this.url,
  });
}

class Url {
  String? raw;
  String? protocol;
  List<String>? host;
  List<String>? path;
  List<Query>? query;

  Url({
    this.raw,
    this.protocol,
    this.host,
    this.path,
    this.query,
  });
}

class Query {
  String? key;
  String? value;

  Query({
    this.key,
    this.value,
  });
}
