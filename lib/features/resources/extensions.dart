import 'package:image_picker/image_picker.dart';

class Utils {
  Utils._();
  static Future<XFile?> pickImageFromGallery() async {
    return await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
  }

 static String timeAgoDetailed(String dateString) {
    try {
      // Parse the string into a DateTime object
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes ago';
      } else {
        return 'just now';
      }
    } catch (e) {
      // Handle parsing errors
      return 'Invalid date';
    }
  }
}
