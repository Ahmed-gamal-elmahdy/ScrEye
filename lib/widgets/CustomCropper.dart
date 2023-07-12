import 'dart:io';

import 'package:croppy/croppy.dart';
import 'package:croppy/src/utils/path.dart' as vg;
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

Future<CropImageResult?> showCustomCropper(
  BuildContext context,
  String imagePath, {
  CroppableImageData? initialData,
  Object? heroTag,
  Future<CropImageResult> Function(CropImageResult)? onCropped,
}) async {
  final imageProvider = FileImage(File(imagePath));

  final _initialData = initialData ??
      await CroppableImageData.fromImageProvider(
        imageProvider,
      );
  if (context.mounted) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CustomCropper(
            imageProvider: imageProvider,
            initialData: _initialData,
            heroTag: heroTag,
            onCropped: onCropped,
          );
        },
      ),
    );
  }

  return null;
}

class CustomCropper extends StatelessWidget {
  const CustomCropper({
    Key? key,
    required this.imageProvider,
    required this.initialData,
    this.heroTag,
    this.onCropped,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final CroppableImageData? initialData;
  final Object? heroTag;
  final Future<CropImageResult> Function(CropImageResult)? onCropped;

  @override
  Widget build(BuildContext context) {
    return DefaultMaterialCroppableImageController(
      imageProvider: imageProvider,
      initialData: initialData,
      cropShapeFn: aabbCropShapeFn,
      allowedAspectRatios: const [CropAspectRatio(width: 4, height: 3)],
      enabledTransformations: const [
        Transformation.panAndScale,
        Transformation.resize
      ],
      builder: (context, controller) {
        return CroppableImagePageAnimator(
          controller: controller,
          heroTag: heroTag,
          builder: (context, overlayOpacityAnimation) {
            return Scaffold(
              appBar: AppBar(
                title: Text(S.of(context).align_clipper),
                actions: [
                  Builder(
                      builder: (context) => Container(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .iconTheme!
                                      .color!,
                                  width: 1,
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.save_alt),
                                onPressed: () async {
                                  CroppableImagePageAnimator.of(context)
                                      ?.setHeroesEnabled(true);

                                  final result = await controller.crop();

                                  if (onCropped != null) {
                                    await onCropped!(result);
                                  }

                                  if (context.mounted) {
                                    Navigator.of(context).pop(result);
                                  }
                                },
                              )))),
                ],
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: AnimatedCroppableImageViewport(
                    minBackgroundOpacity: 0.45,
                    controller: controller,
                    cropHandlesBuilder: (context) =>
                        MaterialImageCropperHandles(
                      controller: controller,
                      gesturePadding: 16.0,
                    ),
                    overlayOpacityAnimation: overlayOpacityAnimation,
                    gesturePadding: 16.0,
                    heroTag: heroTag,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

CropShape myCustomShapFn(vg.PathBuilder builder, Size size) {
  final width = size.width;
  final height = size.height;
  final path = builder
      .moveTo(0, 0)
      .lineTo(0, size.height * 0.32)
      .lineTo(size.width * 0.0534, size.height * 0.3356)
      .lineTo(size.width * 0.1307, size.height * 0.3616)
      .lineTo(size.width * 0.2144, size.height * 0.3878)
      .lineTo(size.width * 0.3062, size.height * 0.4094)
      .lineTo(size.width * 0.4424, size.height * 0.421)
      .lineTo(size.width * 0.57, size.height * 0.4209)
      .lineTo(size.width * 0.6928, size.height * 0.4094)
      .lineTo(size.width * 0.7801, size.height * 0.4025)
      .lineTo(size.width * 0.8706, size.height * 0.3802)
      .lineTo(size.width, size.height * 0.32)
      .lineTo(size.width, 0)
      .lineTo(size.width, size.height * 0.32)
      .lineTo(size.width * 0.9611, size.height * 0.3579)
      .lineTo(size.width * 0.9258, size.height * 0.3898)
      .lineTo(size.width * 0.866, size.height * 0.4219)
      .lineTo(size.width * 0.8, size.height * 0.452)
      .lineTo(size.width * 0.7063, size.height * 0.4799)
      .lineTo(size.width * 0.6123, size.height * 0.4988)
      .lineTo(size.width * 0.5, size.height * 0.4988)
      .lineTo(size.width * 0.5, size.height)
      .lineTo(size.width * 0.5, size.height * 0.4988)
      .lineTo(size.width * 0.3856, size.height * 0.4988)
      .lineTo(size.width * 0.2923, size.height * 0.4799)
      .lineTo(size.width * 0.2144, size.height * 0.452)
      .lineTo(size.width * 0.1415, size.height * 0.4219)
      .lineTo(size.width * 0.0847, size.height * 0.3899)
      .lineTo(size.width * 0.0279, size.height * 0.3579)
      .lineTo(0, size.height * 0.32)
      .close()
      .toPath();
  return CropShape.custom(path);
}
