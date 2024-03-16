class ImageResponse {
  String? copyright;
  String? date;
  String? explanation;
  String? hdurl;
  String? mediaType;
  String? serviceVersion;
  String? title;
  String? url;
  String? thumbnailUrl;

  ImageResponse({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.mediaType,
    this.serviceVersion,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory ImageResponse.fromMap(Map<String, dynamic> data) => ImageResponse(
        copyright: data['copyright'] as String?,
        date: data['date'] as String?,
        explanation: data['explanation'] as String?,
        hdurl: data['hdurl'] as String?,
        mediaType: data['media_type'] as String?,
        serviceVersion: data['service_version'] as String?,
        title: data['title'] as String?,
        url: (data['url'] as String?) != null
            ? !(data['url'] as String?)!.contains('https://')
                ? 'https:${(data['url'] as String?)!}'
                : data['url'] as String?
            : null,
        thumbnailUrl: data['thumbnail_url'] as String?,
      );
}
