class Device {
  final String id;
  final String name;
  final String endpointId;
  final bool isConnected;
  final bool isAvailable;
  Device(
      {required this.id,
      required this.name,
      required this.endpointId,
      required this.isConnected,
      required this.isAvailable});
}
