import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'types.dart';

/// Uniquely identifies a [GroundOverlay] among [GoogleMap] ground overlays.
///
/// This does not have to be globally unique, only unique among the list.
@immutable
class GroundOverlayId extends MapsObjectId<GroundOverlay> {
  /// Creates an immutable identifier for a [GroundOverlay].
  GroundOverlayId(String value) : super(value);
}

/// Draws a ground overlay on the map.
@immutable
class GroundOverlay implements MapsObject<GroundOverlay> {
  /// Creates an immutable representation of a [GroundOverlay] to draw on [GoogleMap].
  /// The following ground overlay positioning is allowed by the Google Maps Api
  /// 1. Using [height], [width] and [LatLng]
  /// 2. Using [width], [width]
  /// 3. Using [LatLngBounds]
  const GroundOverlay({
    required this.groundOverlayId,
    this.consumeTapEvents = false,
    this.location = const LatLng(0.0, 0.0),
    this.zIndex = 0,
    this.onTap,
    this.visible = true,
    this.bitmapDescriptor = BitmapDescriptor.defaultMarker,
    this.bounds,
    this.width = 0.0,
    this.height = 0.0,
    this.bearing = 0.0,
    this.anchor = Offset.zero,
    this.transparency = 0.0,
  }) : assert(
            (height != null && width != null && location != null && bounds == null) ||
                (height == null && width == null && location == null && bounds != null) ||
                (height == null && width != null && location != null && bounds == null) ||
                (height == null && width == null && location == null && bounds == null),
            'Only one of the three types of positioning is allowed, please refer '
            'to the https://developers.google.com/maps/documentation/android-sdk/groundoverlay#add_an_overlay');

  /// Uniquely identifies a [GroundOverlay].
  final GroundOverlayId groundOverlayId;

  @override
  MapsObjectId<GroundOverlay> get mapsId => groundOverlayId;

  /// True if the [GroundOverlay] consumes tap events.
  ///
  /// If this is false, [onTap] callback will not be triggered.
  final bool consumeTapEvents;

  /// Geographical location of the center of the ground overlay.
  final LatLng location;

  /// True if the ground overlay is visible.
  final bool visible;

  /// The z-index of the ground overlay, used to determine relative drawing order of
  /// map overlays.
  ///
  /// Overlays are drawn in order of z-index, so that lower values means drawn
  /// earlier, and thus appearing to be closer to the surface of the Earth.
  final int zIndex;

  /// Callbacks to receive tap events for ground overlay placed on this map.
  final VoidCallback? onTap;

  /// A description of the bitmap used to draw the ground overlay image.
  final BitmapDescriptor bitmapDescriptor;

  /// Width of the ground overlay in meters
  final double width;

  /// Height of the ground overlay in meters
  final double height;

  /// The amount that the image should be rotated in a clockwise direction.
  /// The center of the rotation will be the image's anchor.
  /// This is optional and the default bearing is 0, i.e., the image
  /// is aligned so that up is north.
  final double bearing;

  /// The anchor is, by default, 50% from the top of the image and 50% from the left of the image.
  final Offset anchor;

  /// Transparency of the ground overlay
  final double transparency;

  /// A latitude/longitude alignment of the ground overlay.
  final LatLngBounds? bounds;

  GroundOverlay copyWith({
    BitmapDescriptor? bitmapDescriptorParam,
    Offset? anchorParam,
    int? zIndexParam,
    bool? visibleParam,
    bool? consumeTapEventsParam,
    double? widthParam,
    double? heightParam,
    double? bearingParam,
    LatLng? locationParam,
    LatLngBounds? boundsParam,
    VoidCallback? onTapParam,
    double? transparencyParam,
  }) {
    return GroundOverlay(
        groundOverlayId: groundOverlayId,
        consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
        bitmapDescriptor: bitmapDescriptorParam ?? bitmapDescriptor,
        transparency: transparencyParam ?? transparency,
        location: locationParam ?? location,
        visible: visibleParam ?? visible,
        bearing: bearingParam ?? bearing,
        anchor: anchorParam ?? anchor,
        height: heightParam ?? height,
        bounds: boundsParam ?? bounds,
        zIndex: zIndexParam ?? zIndex,
        width: widthParam ?? width,
        onTap: onTapParam ?? onTap);
  }

  /// Creates a new [GroundOverlay] object whose values are the same as this instance.
  GroundOverlay clone() => copyWith();

  /// Converts this object to something serializable in JSON.
  Object toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('groundOverlayId', groundOverlayId.value);
    addIfPresent('consumeTapEvents', consumeTapEvents);
    addIfPresent('transparency', transparency);
    addIfPresent('bearing', bearing);
    addIfPresent('visible', visible);
    addIfPresent('zIndex', zIndex);
    addIfPresent('height', height);
    addIfPresent('anchor', _offsetToJson(anchor));
    addIfPresent('bounds', bounds?.toJson());
    addIfPresent('bitmap', bitmapDescriptor.toJson());
    addIfPresent('width', width);
    if (location != null) {
      json['location'] = _locationToJson();
    }
    return json;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is GroundOverlay &&
        groundOverlayId == other.groundOverlayId &&
        bitmapDescriptor == other.bitmapDescriptor &&
        consumeTapEvents == other.consumeTapEvents &&
        transparency == other.transparency &&
        location == other.location &&
        bearing == other.bearing &&
        visible == other.visible &&
        height == other.height &&
        zIndex == other.zIndex &&
        bounds == other.bounds &&
        anchor == other.anchor &&
        width == other.width &&
        onTap == other.onTap;
  }

  @override
  int get hashCode => groundOverlayId.hashCode;

  dynamic _locationToJson() => location.toJson();

  dynamic _offsetToJson(Offset offset) {
    if (offset == null) {
      return null;
    }
    return <dynamic>[offset.dx, offset.dy];
  }
}
