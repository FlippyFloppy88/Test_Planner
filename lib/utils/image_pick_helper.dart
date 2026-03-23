import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import '../models/attachment.dart';

const _imgUuid = Uuid();

/// Returns the list of image files inside [planDir] (recursive).
Future<List<File>?> browsePlanImages(BuildContext context, String storageFolderPath, String imageRelativePath) async {
  final planDir = Directory(p.join(storageFolderPath, imageRelativePath));
  if (!await planDir.exists()) {
    if (!context.mounted) return null;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('No images'),
        content: const Text('No images have been stored for this test plan.'),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK'))],
      ),
    );
    return null;
  }
  final files = planDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) {
        final ext = p.extension(f.path).toLowerCase();
        return ['.png', '.jpg', '.jpeg', '.gif', '.webp', '.heic', '.heif'].contains(ext);
      })
      .toList();
  if (files.isEmpty) {
    if (!context.mounted) return null;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('No images'),
        content: const Text('No images found in the plan folder.'),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK'))],
      ),
    );
    return null;
  }
  return files;
}

/// Shows a grid-picker dialog for existing plan images and returns selected path or null.
Future<String?> showBrowsePlanImagesDialog(BuildContext context, List<File> files) {
  return showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Choose image'),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 120,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            childAspectRatio: 1,
          ),
          itemCount: files.length,
          itemBuilder: (c, i) {
            final f = files[i];
            return InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () => Navigator.pop(ctx, f.path),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(f, fit: BoxFit.cover, width: double.infinity,
                          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 40)),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(p.basenameWithoutExtension(f.path),
                      style: const TextStyle(fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            );
          },
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx, null), child: const Text('Cancel'))],
    ),
  );
}

/// Prompts for a hyperlink label and save-as filename given a default name.
/// Returns {'label': ..., 'filename': ...} or null if cancelled.
Future<Map<String, String>?> showImageNameDialog(BuildContext context, String defaultName) {
  final ext = p.extension(defaultName);
  final stem = p.basenameWithoutExtension(defaultName);
  final labelCtrl = TextEditingController(text: stem);
  final fileCtrl = TextEditingController(text: stem);

  return showDialog<Map<String, String>>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Insert Image'),
      content: StatefulBuilder(
        builder: (ctx2, ss) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: labelCtrl,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Hyperlink label',
                hintText: 'e.g. Login screenshot',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: fileCtrl,
                    decoration: InputDecoration(
                      labelText: 'Save image as',
                      suffixText: ext,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Tooltip(
                  message: 'Copy from label',
                  child: IconButton(
                    icon: const Icon(Icons.content_copy, size: 18),
                    onPressed: () => ss(() => fileCtrl.text = labelCtrl.text),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, null), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            final label = labelCtrl.text.trim();
            final file = fileCtrl.text.trim();
            if (label.isEmpty) return;
            Navigator.pop(ctx, {'label': label, 'filename': file.isEmpty ? label : file});
          },
          child: const Text('Insert'),
        ),
      ],
    ),
  );
}

String _mimeFromExtension(String name) {
  final ext = p.extension(name).toLowerCase().replaceFirst('.', '');
  const map = {
    'png': 'image/png', 'jpg': 'image/jpeg', 'jpeg': 'image/jpeg',
    'gif': 'image/gif', 'webp': 'image/webp', 'heic': 'image/heic', 'heif': 'image/heif',
  };
  return map[ext] ?? 'application/octet-stream';
}

String _makeUniqueFileName(Directory dir, String desired) {
  final ext = p.extension(desired);
  final stem = p.basenameWithoutExtension(desired);
  if (!File(p.join(dir.path, desired)).existsSync()) return desired;
  var n = 2;
  while (true) {
    final candidate = '${stem}_$n$ext';
    if (!File(p.join(dir.path, candidate)).existsSync()) return candidate;
    n++;
  }
}

/// Full image pick + save flow.
/// Returns `({attachment, placeholder})` or null if cancelled/errored.
Future<({Attachment attachment, String placeholder})?> pickAndInsertImage({
  required BuildContext context,
  required String storageFolderPath,
  required String imageRelativePath,
}) async {
  if (storageFolderPath.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select a data folder first (Home screen) before adding images.')),
    );
    return null;
  }

  final choice = await showDialog<String>(
    context: context,
    builder: (ctx) => SimpleDialog(
      title: const Text('Insert Image'),
      children: [
        SimpleDialogOption(onPressed: () => Navigator.pop(ctx, 'existing'), child: const Text('Choose existing from plan folder')),
        SimpleDialogOption(onPressed: () => Navigator.pop(ctx, 'new'), child: const Text('Pick a new file from disk')),
        SimpleDialogOption(onPressed: () => Navigator.pop(ctx, null), child: const Text('Cancel')),
      ],
    ),
  );
  if (choice == null) return null;

  String? sourcePath;
  if (choice == 'existing') {
    if (!context.mounted) return null;
    final files = await browsePlanImages(context, storageFolderPath, imageRelativePath);
    if (files == null || !context.mounted) return null;
    sourcePath = await showBrowsePlanImagesDialog(context, files);
    if (sourcePath == null) return null;
  } else {
    final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: false);
    if (result == null || result.files.single.path == null) return null;
    sourcePath = result.files.single.path!;
  }

  final originalName = p.basename(sourcePath);
  final ext = p.extension(originalName);
  if (!context.mounted) return null;

  final imageInfo = await showImageNameDialog(context, originalName);
  if (imageInfo == null) return null;

  final linkLabel = imageInfo['label']!;
  final saveAsName = imageInfo['filename']!;
  final fileName = saveAsName.endsWith(ext) ? saveAsName : '$saveAsName$ext';

  final normalizedStorage = p.normalize(storageFolderPath).toLowerCase();
  final normalizedSource = p.normalize(sourcePath).toLowerCase();
  String relativeFilePath;

  if (normalizedSource.startsWith(normalizedStorage)) {
    relativeFilePath = p.relative(sourcePath, from: storageFolderPath);
  } else {
    final destDir = Directory(p.join(storageFolderPath, imageRelativePath));
    if (!await destDir.exists()) await destDir.create(recursive: true);
    final storedFileName = _makeUniqueFileName(destDir, fileName);
    await File(sourcePath).copy(p.join(destDir.path, storedFileName));
    relativeFilePath = p.join(imageRelativePath, storedFileName);
  }

  final id = _imgUuid.v4();
  final attachment = Attachment(
    id: id,
    fileName: fileName,
    mimeType: _mimeFromExtension(fileName),
    filePath: relativeFilePath,
  );
  final placeholder = '[📎 $linkLabel](attachment:$id)';
  return (attachment: attachment, placeholder: placeholder);
}

/// Shows an image preview dialog.
void showImagePreview(BuildContext context, Attachment att, String storageFolderPath) {
  final absPath = att.filePath.isNotEmpty && storageFolderPath.isNotEmpty
      ? p.join(storageFolderPath, att.filePath)
      : null;

  Widget imageWidget;
  if (absPath != null && File(absPath).existsSync()) {
    imageWidget = InteractiveViewer(child: Image.file(File(absPath)));
  } else {
    imageWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.broken_image, size: 64),
        const SizedBox(height: 8),
        Text(absPath != null ? 'File not found:\n$absPath' : 'No image data', textAlign: TextAlign.center),
      ],
    );
  }

  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            title: Text(att.fileName),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
          ),
          Flexible(child: imageWidget),
        ],
      ),
    ),
  );
}
