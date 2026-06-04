import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'
    as cacheManager;
import 'package:gps_software/generated/assets.dart';
import 'package:photo_view/photo_view.dart';

class CustomFadeInImage extends StatefulWidget {
  final String url;
  final String? placeHolder;
  final BoxFit? fit;
  final Color? color;
  final double? width;
  final double? height;
  final Widget? placeHolderWidget;
  final Function? imageLoaded;
  final bool clearCache;
  final bool isShowPhotoView;

  const CustomFadeInImage({
    super.key,
    required this.url,
    this.placeHolder,
    this.fit,
    this.color,
    this.width,
    this.height,
    this.placeHolderWidget,
    this.imageLoaded,
    this.clearCache = false,
    this.isShowPhotoView = false,
  });

  @override
  State<CustomFadeInImage> createState() => _CustomFadeInImageState();
}

class _CustomFadeInImageState extends State<CustomFadeInImage> {
  cacheManager.Config config = cacheManager.Config("featureStoreKey");

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      imageUrl: widget.url,
      color: widget.color,
      cacheManager:
          widget.clearCache ? cacheManager.CacheManager.custom(config) : null,
      fadeInDuration: Duration(milliseconds: 0),
      imageBuilder: (context, ImageProvider<Object> imageProvider) {
        print("ImageProvider ===>   ${imageProvider.runtimeType}");
        if (widget.imageLoaded != null) {
          widget.imageLoaded!();
        }
        if (widget.isShowPhotoView) {
          return PhotoView(
            imageProvider: imageProvider,
            backgroundDecoration: const BoxDecoration(
              color: Colors.white,
            ),
            heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
          );
        }
        return Image(
          image: imageProvider,
          width: widget.width,
          height: widget.height,
          color: widget.color,
          fit: widget.fit,
        );
      },
      placeholder: (_, __) {
        if (widget.placeHolderWidget != null) {
          return widget.placeHolderWidget!;
        }
        return Center(
          child: Image.asset(
            widget.placeHolder ?? Assets.assetsAppLogo,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          ),
        );
      },
      errorWidget: (_, __, ___) {
        if (widget.imageLoaded != null) {
          widget.imageLoaded!();
        }
        return Image.file(
          File(
            widget.url,
          ),
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          errorBuilder: (_, __, ___) {
            if (widget.placeHolderWidget != null) {
              return widget.placeHolderWidget!;
            }
            return Image.asset(
              widget.placeHolder ?? Assets.assetsAppLogo,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    config = cacheManager.Config(
      "featureStoreKey",
      stalePeriod: const Duration(seconds: 0),
      maxNrOfCacheObjects: 1,
      repo:
          cacheManager.JsonCacheInfoRepository(databaseName: "featureStoreKey"),
      fileService: cacheManager.HttpFileService(),
    );
  }
}
