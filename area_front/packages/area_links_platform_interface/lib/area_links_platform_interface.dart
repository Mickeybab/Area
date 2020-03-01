library area_links_platform_interface;


/// The interface used to handle the following Flow:
/// - Interact with browser instance opened for login
abstract class AreaLinksPlatform {

  /// Register a callback to be call when :
  /// - The opened browser instance redirect to the correct url
  dynamic registerCallbackHandler(void Function(String a) callback) {
    throw UnimplementedError("cancel() has not been implemented.");
  }

  /// Clear the link
  cancel() {
    throw UnimplementedError("cancel() has not been implemented.");
  }

  Future sendNotification(dynamic message) {
    throw UnimplementedError("sendNotification() has not been implemented.");
  }
}
