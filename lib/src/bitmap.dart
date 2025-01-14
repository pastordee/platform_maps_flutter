part of '../platform_maps_flutter.dart';

/// Defines a bitmap image. For a marker, this class can be used to set the
/// image of the marker icon. For a ground overlay, it can be used to set the
/// image to place on the surface of the earth.

class BitmapDescriptor {
  final dynamic bitmapDescriptor;

  BitmapDescriptor._(this.bitmapDescriptor);

  /// Creates a BitmapDescriptor that refers to the default marker image.
  static BitmapDescriptor? get defaultMarker {
    if (UniversalPlatform.isIOS) {
      return BitmapDescriptor._(apple_maps.BitmapDescriptor.defaultAnnotation);
    } else if (UniversalPlatform.isAndroid) {
      return BitmapDescriptor._(google_maps.BitmapDescriptor.defaultMarker);
    }
    return BitmapDescriptor._(google_maps.BitmapDescriptor.defaultMarker);
  }

  /// Creates a [BitmapDescriptor] from an asset image.
  /// Asset images in flutter are stored per: https://flutter.dev/docs/development/ui/assets-and-images#declaring-resolution-aware-image-assets
  ///
  /// This method takes into consideration various asset resolutions and scales the images to the right resolution depending on the dpi.
  ///
  /// Don't forget to rebuild the map with the new Icons if it was already build.
  static Future<BitmapDescriptor> fromAssetImage(
    ImageConfiguration configuration,
    String assetName, {
    AssetBundle? bundle,
    String? package,
  }) async {
    dynamic bitmap;
    if (UniversalPlatform.isIOS) {
      bitmap = await apple_maps.BitmapDescriptor.fromAssetImage(
        configuration,
        assetName,
        bundle: bundle,
        package: package,
      );
    } else if (UniversalPlatform.isAndroid) {
      bitmap = await google_maps.BitmapDescriptor.asset(
        configuration,
        assetName,
        bundle: bundle,
        package: package,
      );
    }else if (UniversalPlatform.isWeb) {
      bitmap = await google_maps.BitmapDescriptor.asset(
        configuration,
        assetName,
        bundle: bundle,
        package: package,
      );
    }
    return BitmapDescriptor._(bitmap);
  }

  /// Creates a BitmapDescriptor using an array of bytes that must be encoded
  /// as PNG.
  static BitmapDescriptor fromBytes(Uint8List byteData) {
    var bitmap = UniversalPlatform.isAndroid
        ? google_maps.BitmapDescriptor.bytes(byteData)
        : UniversalPlatform.isWeb ?google_maps.BitmapDescriptor.bytes(byteData):apple_maps.BitmapDescriptor.fromBytes(byteData);
    return BitmapDescriptor._(bitmap);
  }
}