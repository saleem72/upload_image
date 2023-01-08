import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UploadFileResponse {
  final UploadResponseData? data;
  final bool success;
  final int status;
  // final int status_code;
  UploadFileResponse({
    required this.data,
    required this.success,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.toMap(),
      'success': success,
      'status': status,
    };
  }

  factory UploadFileResponse.fromMap(Map<String, dynamic> map) {
    return UploadFileResponse(
      data: map['data'] == null
          ? null
          : UploadResponseData.fromMap(map['data'] as Map<String, dynamic>),
      success: map['success'] as bool,
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadFileResponse.fromJson(String source) =>
      UploadFileResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UploadFileResponse(data: ${data.toString()},\nsuccess: $success,\nstatus: $status)';
}

class UploadResponseData {
  final String id;
  final String title;
  final String urlViewer;
  final String url;
  final String displayUrl;
  final String width;
  final String height;
  final double size;
  final String time;
  final String expiration;
  final UploadResponseFileDetails? image;
  final UploadResponseFileDetails? thumb;
  final UploadResponseFileDetails? medium;
  final String deleteUrl;
  UploadResponseData({
    required this.id,
    required this.title,
    required this.urlViewer,
    required this.url,
    required this.displayUrl,
    required this.width,
    required this.height,
    required this.size,
    required this.time,
    required this.expiration,
    required this.image,
    required this.thumb,
    required this.medium,
    required this.deleteUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'url_viewer': urlViewer,
      'url': url,
      'display_url': displayUrl,
      'width': width,
      'height': height,
      'size': size,
      'time': time,
      'expiration': expiration,
      'image': image?.toMap(),
      'thumb': thumb?.toMap(),
      'medium': medium?.toMap(),
      'delete_url': deleteUrl,
    };
  }

  factory UploadResponseData.fromMap(Map<String, dynamic> map) {
    return UploadResponseData(
      id: map['id'] as String,
      title: map['title'] as String,
      urlViewer: map['url_viewer'] as String,
      url: map['url'] as String,
      displayUrl: map['display_url'] as String,
      width: map['width'] as String,
      height: map['height'] as String,
      size: (map['size'] is int)
          ? (map['size'] as int).toDouble()
          : map['size'] as double,
      time: map['time'] as String,
      expiration: map['expiration'] as String,
      image: map['image'] == null
          ? null
          : UploadResponseFileDetails.fromMap(
              map['image'] as Map<String, dynamic>),
      thumb: map['thumb'] == null
          ? null
          : UploadResponseFileDetails.fromMap(
              map['thumb'] as Map<String, dynamic>),
      medium: map['medium'] == null
          ? null
          : UploadResponseFileDetails.fromMap(
              map['medium'] as Map<String, dynamic>),
      deleteUrl: map['delete_url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadResponseData.fromJson(String source) =>
      UploadResponseData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(id: $id,\ntitle: $title,\nurlViewer: $urlViewer,\nurl: $url,\ndisplayUrl: $displayUrl,\nwidth: $width,\nheight: $height,\nsize: $size,\ntime: $time,\nexpiration: $expiration,\nimage: $image,\nthumb: $thumb,\nmedium: $medium,\ndeleteUrl: $deleteUrl)';
  }
}

class UploadResponseFileDetails {
  final String filename;
  final String name;
  final String mime;
  final String extension;
  final String url;
  UploadResponseFileDetails({
    required this.filename,
    required this.name,
    required this.mime,
    required this.extension,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filename': filename,
      'name': name,
      'mime': mime,
      'extension': extension,
      'url': url,
    };
  }

  factory UploadResponseFileDetails.fromMap(Map<String, dynamic> map) {
    return UploadResponseFileDetails(
      filename: map['filename'] as String? ?? '',
      name: map['name'] as String? ?? '',
      mime: map['mime'] as String? ?? '',
      extension: map['extension'] as String? ?? '',
      url: map['url'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadResponseFileDetails.fromJson(String source) =>
      UploadResponseFileDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Image(filename: $filename, name: $name, mime: $mime, extension: $extension, url: $url)';
  }
}
/*
final _aa = {
  "data": {
    "id": "hmttkTd",
    "title": "user20",
    "url_viewer": "https://ibb.co/hmttkTd",
    "url": "https://i.ibb.co/sVMMhX1/user20.jpg",
    "display_url": "https://i.ibb.co/HHkk09P/user20.jpg",
    "width": "992",
    "height": "995",
    "size": 75349,
    "time": "1672302881",
    "expiration": "0",
    "image": {
      "filename": "user20.jpg",
      "name": "user20",
      "mime": "image/jpeg",
      "extension": "jpg",
      "url": "https://i.ibb.co/sVMMhX1/user20.jpg"
    },
    "thumb": {
      "filename": "user20.jpg",
      "name": "user20",
      "mime": "image/jpeg",
      "extension": "jpg",
      "url": "https://i.ibb.co/hmttkTd/user20.jpg"
    },
    "medium": {
      "filename": "user20.jpg",
      "name": "user20",
      "mime": "image/jpeg",
      "extension": "jpg",
      "url": "https://i.ibb.co/HHkk09P/user20.jpg"
    },
    "delete_url": "https://ibb.co/hmttkTd/5db4df2e2e34fcf75f1ab38948b30e5e"
  },
  "success": true,
  "status": 200
};
*/

final temp = {
  "data": {
    "id": "ggCBTHJ",
    "title": "1672312304958",
    "url_viewer": "https:\/\/ibb.co\/ggCBTHJ",
    "url": "https:\/\/i.ibb.co\/BsRSZdB\/1672312304958.jpg",
    "display_url": "https:\/\/i.ibb.co\/BsRSZdB\/1672312304958.jpg",
    "width": "243",
    "height": "207",
    "size": 4115,
    "time": "1672312311",
    "expiration": "0",
    "image": {
      "filename": "1672312304958.jpg",
      "name": "1672312304958",
      "mime": "image\/jpeg",
      "extension": "jpg",
      "url": "https://i.ibb.co/BsRSZdB/1672312304958.jpg"
    },
    "thumb": {
      "filename": "1672312304958.jpg",
      "name": "1672312304958",
      "mime": "image\/jpeg",
      "extension": "jpg",
      "url": "https:\/\/i.ibb.co\/ggCBTHJ\/1672312304958.jpg"
    },
    "delete_url": "https:\/\/ibb.co\/ggCBTHJ\/93e99d4eb6cf90a5a51d97e6fc07fa22"
  },
  "success": true,
  "status": 200
};
