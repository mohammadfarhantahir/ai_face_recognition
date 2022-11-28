import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:ai_face/const/globals.dart' as globals;

import 'mlkit_coordinate_translate.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.faces, this.absoluteImageSize, this.rotation);

  final List<Face> faces;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Color(0xff6B5EFE),
      fontSize: 10,
    );
    final textSpan = TextSpan(
      text: 'Powered by NiGELLA SOFTWARES',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );


    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..color = Color(0xff6B5EFE);

    for (final Face face in faces) {
      canvas.drawRect(
        Rect.fromLTRB(
          translateX(face.boundingBox.left, rotation, size, absoluteImageSize),
          translateY(face.boundingBox.top, rotation, size, absoluteImageSize),
          translateX(face.boundingBox.right, rotation, size, absoluteImageSize),
          translateY(
              face.boundingBox.bottom, rotation, size, absoluteImageSize),
        ),

        paint,
      );
      final xCenter = translateX(face.boundingBox.centerLeft.dx, rotation, size, absoluteImageSize);
      final yCenter = translateY(face.boundingBox.center.dx, rotation, size, absoluteImageSize);
      final offset = Offset(xCenter, yCenter);

      void paintContour(FaceContourType type) {
        final faceContour = face.contours[type];
        if (faceContour?.points != null) {
          for (final Point point in faceContour!.points) {
            textPainter.paint(canvas, offset);
            globals.takingimagestatus = true;
            canvas.drawCircle(
                Offset(
                  translateX(
                      point.x.toDouble(), rotation, size, absoluteImageSize),
                  translateY(
                      point.y.toDouble(), rotation, size, absoluteImageSize),
                ),
                1,
                paint);
          }
        }
        else{
          globals.takingimagestatus = false;
        }
      }

      paintContour(FaceContourType.face);
      /* paintContour(FaceContourType.leftEyebrowTop);
      paintContour(FaceContourType.leftEyebrowBottom);
      paintContour(FaceContourType.rightEyebrowTop);
      paintContour(FaceContourType.rightEyebrowBottom);
      paintContour(FaceContourType.leftEye);
      paintContour(FaceContourType.rightEye);
      paintContour(FaceContourType.upperLipTop);
      paintContour(FaceContourType.upperLipBottom);
      paintContour(FaceContourType.lowerLipTop);
      paintContour(FaceContourType.lowerLipBottom);
      paintContour(FaceContourType.noseBridge);
      paintContour(FaceContourType.noseBottom);
      paintContour(FaceContourType.leftCheek);
      paintContour(FaceContourType.rightCheek);*/
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    globals.takingimagestatus = false;
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.faces != faces;
  }
}

