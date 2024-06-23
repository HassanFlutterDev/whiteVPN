import 'dart:convert';

class ServerModel {
  final bool status;
  final List<Server> servers;

  ServerModel({
    required this.status,
    required this.servers,
  });

  factory ServerModel.fromRawJson(String str) =>
      ServerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServerModel.fromJson(Map<String, dynamic> json) => ServerModel(
        status: json["status"],
        servers:
            List<Server>.from(json["servers"].map((x) => Server.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "servers": List<dynamic>.from(servers.map((x) => x.toJson())),
      };
}

class Server {
  final int serverId;
  final String serverName;
  final String serverImg;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SubServer> subServers;

  Server({
    required this.serverId,
    required this.serverName,
    required this.serverImg,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.subServers,
  });

  factory Server.fromRawJson(String str) => Server.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Server.fromJson(Map<String, dynamic> json) => Server(
        serverId: json["server_id"],
        serverName: json["server_name"],
        serverImg: json["server_img"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        subServers: List<SubServer>.from(
            json["sub_servers"].map((x) => SubServer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "server_id": serverId,
        "server_name": serverName,
        "server_img": serverImg,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "sub_servers": List<dynamic>.from(subServers.map((x) => x.toJson())),
      };
}

class SubServer {
  final int subServerId;
  final int serverId;
  final String subServerName;
  final String subServerConfig;
  final String ipAddress;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubServer({
    required this.subServerId,
    required this.serverId,
    required this.subServerName,
    required this.subServerConfig,
    required this.ipAddress,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubServer.fromRawJson(String str) =>
      SubServer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubServer.fromJson(Map<String, dynamic> json) => SubServer(
        subServerId: json["sub_server_id"],
        serverId: json["server_id"],
        subServerName: json["sub_server_name"],
        subServerConfig: json["sub_server_config"],
        ipAddress: json["ip_addresss"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "sub_server_id": subServerId,
        "server_id": serverId,
        "sub_server_name": subServerName,
        "sub_server_config": subServerConfig,
        "ip_addresss": ipAddress,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
