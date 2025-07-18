import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/widgets.dart'; // Added for BuildContext

enum FileUploadType {
  profilePicture,
  resume,
  coverLetter,
}

class FileUploadService {
  static final FileUploadService _instance = FileUploadService._internal();
  factory FileUploadService() => _instance;
  FileUploadService._internal();

  final ImagePicker _imagePicker = ImagePicker();

  /// Upload a PDF file (resume or cover letter)
  Future<String?> uploadPDF({
    required FileUploadType type,
    String? customFileName,
  }) async {
    try {
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception('Storage permission is required to upload files');
      }

      // Pick PDF file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        
        if (file.path != null) {
          // Get app documents directory
          final appDir = await getApplicationDocumentsDirectory();
          final uploadsDir = Directory('${appDir.path}/uploads');
          
          // Create uploads directory if it doesn't exist
          if (!await uploadsDir.exists()) {
            await uploadsDir.create(recursive: true);
          }

          // Generate unique filename
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final extension = file.extension ?? 'pdf';
          final fileName = customFileName ?? 
            '${type.name}_${timestamp}.$extension';
          
          final destinationPath = '${uploadsDir.path}/$fileName';

          // Copy file to app directory
          final sourceFile = File(file.path!);
          final destinationFile = await sourceFile.copy(destinationPath);

          print('File uploaded successfully: $destinationPath');
          return destinationPath;
        }
      }
      
      return null;
    } catch (e) {
      print('Error uploading PDF: $e');
      rethrow;
    }
  }

  /// Upload an image (profile picture)
  Future<String?> uploadImage({
    required FileUploadType type,
    String? customFileName,
  }) async {
    try {
      // Request camera and storage permissions
      final cameraStatus = await Permission.camera.request();
      final storageStatus = await Permission.storage.request();
      
      if (!cameraStatus.isGranted && !storageStatus.isGranted) {
        throw Exception('Camera and storage permissions are required');
      }

      // Pick image from gallery or camera
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        // Get app documents directory
        final appDir = await getApplicationDocumentsDirectory();
        final uploadsDir = Directory('${appDir.path}/uploads');
        
        // Create uploads directory if it doesn't exist
        if (!await uploadsDir.exists()) {
          await uploadsDir.create(recursive: true);
        }

        // Generate unique filename
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = customFileName ?? 
          '${type.name}_${timestamp}.jpg';
        
        final destinationPath = '${uploadsDir.path}/$fileName';

        // Copy image to app directory
        final sourceFile = File(image.path);
        final destinationFile = await sourceFile.copy(destinationPath);

        print('Image uploaded successfully: $destinationPath');
        return destinationPath;
      }
      
      return null;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  /// Delete a file
  Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        print('File deleted successfully: $filePath');
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting file: $e');
      return false;
    }
  }

  /// Check if file exists
  Future<bool> fileExists(String filePath) async {
    try {
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  /// Get file size in bytes
  Future<int?> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Get formatted file size (KB, MB, etc.)
  String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Get file extension from path
  String getFileExtension(String filePath) {
    return filePath.split('.').last.toLowerCase();
  }

  /// Validate file type
  bool isValidFileType(String filePath, List<String> allowedExtensions) {
    final extension = getFileExtension(filePath);
    return allowedExtensions.contains(extension);
  }

  /// Get uploads directory path
  Future<String> getUploadsDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    return '${appDir.path}/uploads';
  }

  /// List all uploaded files
  Future<List<FileSystemEntity>> listUploadedFiles() async {
    try {
      final uploadsDir = await getUploadsDirectory();
      final directory = Directory(uploadsDir);
      
      if (await directory.exists()) {
        return await directory.list().toList();
      }
      return [];
    } catch (e) {
      print('Error listing uploaded files: $e');
      return [];
    }
  }

  /// Clear all uploaded files
  Future<bool> clearAllUploads() async {
    try {
      final uploadsDir = await getUploadsDirectory();
      final directory = Directory(uploadsDir);
      
      if (await directory.exists()) {
        await directory.delete(recursive: true);
        print('All uploads cleared successfully');
        return true;
      }
      return false;
    } catch (e) {
      print('Error clearing uploads: $e');
      return false;
    }
  }

  /// Pick and upload file based on type
  Future<String?> pickAndUploadFile(
    FileUploadType type,
    BuildContext context, {
    String? customFileName,
  }) async {
    try {
      switch (type) {
        case FileUploadType.profilePicture:
          return await uploadImage(type: type, customFileName: customFileName);
        case FileUploadType.resume:
        case FileUploadType.coverLetter:
          return await uploadPDF(type: type, customFileName: customFileName);
      }
    } catch (e) {
      print('Error picking and uploading file: $e');
      rethrow;
    }
  }
}