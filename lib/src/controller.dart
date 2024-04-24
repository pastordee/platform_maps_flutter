part of '../platform_maps_flutter.dart';

class PlatformMapController {
  apple_maps.AppleMapController? appleController;
  google_maps.GoogleMapController? googleController;

  PlatformMapController(dynamic controller) {
    if (controller.runtimeType == google_maps.GoogleMapController) {
      googleController = controller;
    } else if (controller.runtimeType == apple_maps.AppleMapController) {
      appleController = controller;
    }
  }

  /// Programmatically show the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> showMarkerInfoWindow(MarkerId markerId) {
    if (UniversalPlatform.isAndroid) {
      return googleController!
          .showMarkerInfoWindow(markerId.googleMapsMarkerId);
    } else if (UniversalPlatform.isIOS) {
      return appleController!
          .showMarkerInfoWindow(markerId.appleMapsAnnoationId);
    }
    throw ('Platform not supported.');
  }

  /// Programmatically hide the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> hideMarkerInfoWindow(MarkerId markerId) {
    if (UniversalPlatform.isAndroid) {
      return googleController!
          .hideMarkerInfoWindow(markerId.googleMapsMarkerId);
    } else if (UniversalPlatform.isIOS) {
      return appleController!
          .hideMarkerInfoWindow(markerId.appleMapsAnnoationId);
    }
    throw ('Platform not supported.');
  }

  /// Returns `true` when the [InfoWindow] is showing, `false` otherwise.
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  Future<bool> isMarkerInfoWindowShown(MarkerId markerId) async {
    if (UniversalPlatform.isAndroid) {
      return googleController!
          .isMarkerInfoWindowShown(markerId.googleMapsMarkerId);
    } else if (UniversalPlatform.isIOS) {
      return await appleController!
              .isMarkerInfoWindowShown(markerId.appleMapsAnnoationId) ??
          false;
    }
    throw ('Platform not supported.');
  }

  /// Starts an animated change of the map camera position.
  ///
  /// The returned [Future] completes after the change has been started on the
  /// platform side.
  Future<void> animateCamera(cameraUpdate) async {
    if (UniversalPlatform.isIOS) {
      return appleController!.animateCamera(cameraUpdate);
    } else if (UniversalPlatform.isAndroid) {
      return googleController!.animateCamera(cameraUpdate);
    }
    throw ('Platform not supported.');
  }

  /// Changes the map camera position.
  ///
  /// The returned [Future] completes after the change has been made on the
  /// platform side.
  Future<void> moveCamera(cameraUpdate) async {
    if (UniversalPlatform.isIOS) {
      return appleController!.moveCamera(cameraUpdate);
    } else if (UniversalPlatform.isAndroid) {
      return googleController!.moveCamera(cameraUpdate);
    }
  }

  /// Return [LatLngBounds] defining the region that is visible in a map.
  Future<LatLngBounds> getVisibleRegion() async {
    late LatLngBounds bounds;
    if (UniversalPlatform.isIOS) {
      apple_maps.LatLngBounds appleBounds =
          await appleController!.getVisibleRegion();
      bounds = LatLngBounds._fromAppleLatLngBounds(appleBounds);
    } else if (UniversalPlatform.isAndroid) {
      google_maps.LatLngBounds googleBounds =
          await googleController!.getVisibleRegion();
      bounds = LatLngBounds._fromGoogleLatLngBounds(googleBounds);
    }
    return bounds;
  }

  /// Returns the image bytes of the map
  Future<Uint8List?> takeSnapshot() async {
    if (UniversalPlatform.isIOS) {
      return appleController!.takeSnapshot();
    } else if (UniversalPlatform.isAndroid) {
      return googleController!.takeSnapshot();
    }
    throw UnsupportedError('platform_maps only supports iOS and Android');
  }
}