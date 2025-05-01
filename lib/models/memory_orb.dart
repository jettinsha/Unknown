class MemoryOrb {
  final String id;
  final String title;
  final String message;
  final String imagePath;
  final String? audioPath;
  final String? videoPath;
  final bool isLocked;
  final DateTime? revealTime;

  const MemoryOrb({
    required this.id,
    required this.title,
    required this.message,
    required this.imagePath,
    this.audioPath,
    this.videoPath,
    this.isLocked = false,
    this.revealTime,
  });

  factory MemoryOrb.fromJson(Map<String, dynamic> json) {
    return MemoryOrb(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      imagePath: json['imagePath'] as String,
      audioPath: json['audioPath'] as String?,
      videoPath: json['videoPath'] as String?,
      isLocked: json['isLocked'] as bool? ?? false,
      revealTime:
          json['revealTime'] != null
              ? DateTime.parse(json['revealTime'] as String)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'imagePath': imagePath,
      'audioPath': audioPath,
      'videoPath': videoPath,
      'isLocked': isLocked,
      'revealTime': revealTime?.toIso8601String(),
    };
  }
}
