import 'package:movies/features/movie_details/domain/entity/movie_details.dart';

/// status : "ok"
/// status_message : "Query was successful"
/// data : {"movie":{"id":11,"url":"https://yts.lt/movies/13-eerie-2013","imdb_code":"tt2082152","title":"13 Eerie","title_english":"13 Eerie","title_long":"13 Eerie (2013)","slug":"13-eerie-2013","year":2013,"rating":4.5,"runtime":87,"genres":["Action","Horror","Sci-Fi"],"like_count":24,"description_intro":"Forensics students arrive on an isolated island, much like a body farm, get to try out their CSI skills on a bunch of corpses under the watchful eye of their grumpy professor. The island used to house a state penitentiary where the authorities were experimenting on death row inmates and now the bodies won't stay still.","description_full":"Forensics students arrive on an isolated island, much like a body farm, get to try out their CSI skills on a bunch of corpses under the watchful eye of their grumpy professor. The island used to house a state penitentiary where the authorities were experimenting on death row inmates and now the bodies won't stay still.","yt_trailer_code":"Mr0NM0draJo","language":"en","mpa_rating":"","background_image":"https://yts.lt/assets/images/movies/13_Eerie_2013/background.jpg","background_image_original":"https://yts.lt/assets/images/movies/13_Eerie_2013/background.jpg","small_cover_image":"https://yts.lt/assets/images/movies/13_Eerie_2013/small-cover.jpg","medium_cover_image":"https://yts.lt/assets/images/movies/13_Eerie_2013/medium-cover.jpg","large_cover_image":"https://yts.lt/assets/images/movies/13_Eerie_2013/large-cover.jpg","medium_screenshot_image1":"https://yts.lt/assets/images/movies/13_Eerie_2013/medium-screenshot1.jpg","medium_screenshot_image2":"https://yts.lt/assets/images/movies/13_Eerie_2013/medium-screenshot2.jpg","medium_screenshot_image3":"https://yts.lt/assets/images/movies/13_Eerie_2013/medium-screenshot3.jpg","large_screenshot_image1":"https://yts.lt/assets/images/movies/13_Eerie_2013/large-screenshot1.jpg","large_screenshot_image2":"https://yts.lt/assets/images/movies/13_Eerie_2013/large-screenshot2.jpg","large_screenshot_image3":"https://yts.lt/assets/images/movies/13_Eerie_2013/large-screenshot3.jpg","cast":[{"name":"Jesse Moss","character_name":"Patrick","url_small_image":"https://yts.lt/assets/images/actors/thumb/nm1536605.jpg","imdb_code":"1536605"},{"name":"Katharine Isabelle","character_name":"Megan","url_small_image":"https://yts.lt/assets/images/actors/thumb/nm0410622.jpg","imdb_code":"0410622"},{"name":"Brendan Fletcher","character_name":"Josh","url_small_image":"https://yts.lt/assets/images/actors/thumb/nm0281956.jpg","imdb_code":"0281956"},{"name":"Shannon Jardine","character_name":"Skinhead Nazi Zombie","imdb_code":"1266084"}],"torrents":[{"url":"https://yts.lt/torrent/download/9E74E644A45E1A7F5520ED6C046410A1E733ADFB","hash":"9E74E644A45E1A7F5520ED6C046410A1E733ADFB","quality":"720p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"698.43 MB","size_bytes":732356936,"date_uploaded":"2019-07-26 15:57:07","date_uploaded_unix":1564149427},{"url":"https://yts.lt/torrent/download/B423E5BDFAC29096C11015DAA72401C769FFCA10","hash":"B423E5BDFAC29096C11015DAA72401C769FFCA10","quality":"1080p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.24 GB","size_bytes":1331439862,"date_uploaded":"2015-10-31 20:46:54","date_uploaded_unix":1446320814}],"date_uploaded":"2019-07-26 15:57:07","date_uploaded_unix":1564149427}}
/// @meta : {"server_time":1763901258,"server_timezone":"CET","api_version":2,"execution_time":"0 ms"}

class MovieDetailsResponse {
  MovieDetailsResponse({
      this.status, 
      this.statusMessage, 
      this.data, 
      this.meta,});

  MovieDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? Meta.fromJson(json['@meta']) : null;
  }
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (meta != null) {
      map['@meta'] = meta?.toJson();
    }
    return map;
  }

}

/// server_time : 1763901258
/// server_timezone : "CET"
/// api_version : 2
/// execution_time : "0 ms"

class Meta {
  Meta({
      this.serverTime, 
      this.serverTimezone, 
      this.apiVersion, 
      this.executionTime,});

  Meta.fromJson(dynamic json) {
    serverTime = json['server_time'];
    serverTimezone = json['server_timezone'];
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }
  num? serverTime;
  String? serverTimezone;
  num? apiVersion;
  String? executionTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['server_time'] = serverTime;
    map['server_timezone'] = serverTimezone;
    map['api_version'] = apiVersion;
    map['execution_time'] = executionTime;
    return map;
  }

}

/// movie : {"id":11,"url":"https://yts.lt/movies/13-eerie-2013","imdb_code":"tt2082152","title":"13 Eerie","title_english":"13 Eerie","title_long":"13 Eerie (2013)","slug":"13-eerie-2013","year":2013,"rating":4.5,"runtime":87,"genres":["Action","Horror","Sci-Fi"],"like_count":24,"description_intro":"Forensics students arrive on an isolated island, much like a body farm, get to try out their CSI skills on a bunch of corpses under the watchful eye of their grumpy professor. The island used to house a state penitentiary where the authorities were experimenting on death row inmates and now the bodies won't stay still.","description_full":"Forensics students arrive on an isolated island, much like a body farm, get to try out their CSI skills on a bunch of corpses under the watchful eye of their grumpy professor. The island used to house a state penitentiary where the authorities were experimenting on death row inmates and now the bodies won't stay still.","yt_trailer_code":"Mr0NM0draJo","language":"en","mpa_rating":"","background_image":"https://yts.lt/assets/images/movies/13_Eerie_2013/background.jpg","background_image_original":"https://yts.lt/assets/images/movies/13_Eerie_2013/background.jpg","small_cover_image":"https://yts.lt/assets/images/movies/13_Eerie_2013/small-cover.jpg","medium_cover_image":"https://yts.lt/assets/images/movies/13_Eerie_2013/medium-cover.jpg","large_cover_image":"https://yts.lt/assets/images/movies/13_Eerie_2013/large-cover.jpg","medium_screenshot_image1":"https://yts.lt/assets/images/movies/13_Eerie_2013/medium-screenshot1.jpg","medium_screenshot_image2":"https://yts.lt/assets/images/movies/13_Eerie_2013/medium-screenshot2.jpg","medium_screenshot_image3":"https://yts.lt/assets/images/movies/13_Eerie_2013/medium-screenshot3.jpg","large_screenshot_image1":"https://yts.lt/assets/images/movies/13_Eerie_2013/large-screenshot1.jpg","large_screenshot_image2":"https://yts.lt/assets/images/movies/13_Eerie_2013/large-screenshot2.jpg","large_screenshot_image3":"https://yts.lt/assets/images/movies/13_Eerie_2013/large-screenshot3.jpg","cast":[{"name":"Jesse Moss","character_name":"Patrick","url_small_image":"https://yts.lt/assets/images/actors/thumb/nm1536605.jpg","imdb_code":"1536605"},{"name":"Katharine Isabelle","character_name":"Megan","url_small_image":"https://yts.lt/assets/images/actors/thumb/nm0410622.jpg","imdb_code":"0410622"},{"name":"Brendan Fletcher","character_name":"Josh","url_small_image":"https://yts.lt/assets/images/actors/thumb/nm0281956.jpg","imdb_code":"0281956"},{"name":"Shannon Jardine","character_name":"Skinhead Nazi Zombie","imdb_code":"1266084"}],"torrents":[{"url":"https://yts.lt/torrent/download/9E74E644A45E1A7F5520ED6C046410A1E733ADFB","hash":"9E74E644A45E1A7F5520ED6C046410A1E733ADFB","quality":"720p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"698.43 MB","size_bytes":732356936,"date_uploaded":"2019-07-26 15:57:07","date_uploaded_unix":1564149427},{"url":"https://yts.lt/torrent/download/B423E5BDFAC29096C11015DAA72401C769FFCA10","hash":"B423E5BDFAC29096C11015DAA72401C769FFCA10","quality":"1080p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.24 GB","size_bytes":1331439862,"date_uploaded":"2015-10-31 20:46:54","date_uploaded_unix":1446320814}],"date_uploaded":"2019-07-26 15:57:07","date_uploaded_unix":1564149427}

class Data {
  Data({
      this.movie,});

  Data.fromJson(dynamic json) {
    movie = json['movie'] != null ? MovieDetailsDto.fromJson(json['movie']) : null;
  }
  MovieDetailsDto? movie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (movie != null) {
      map['movie'] = movie?.toJson();
    }
    return map;
  }

}

/// id : 11
/// url : "https://yts.lt/movies/13-eerie-2013"
/// imdb_code : "tt2082152"
/// title : "13 Eerie"
/// title_english : "13 Eerie"
/// title_long : "13 Eerie (2013)"
/// slug : "13-eerie-2013"
/// year : 2013
/// rating : 4.5
/// runtime : 87
/// genres : ["Action","Horror","Sci-Fi"]
/// like_count : 24
/// description_intro : "Forensics students arrive on an isolated island, much like a body farm, get to try out their CSI skills on a bunch of corpses under the watchful eye of their grumpy professor. The island used to house a state penitentiary where the authorities were experimenting on death row inmates and now the bodies won't stay still."
/// description_full : "Forensics students arrive on an isolated island, much like a body farm, get to try out their CSI skills on a bunch of corpses under the watchful eye of their grumpy professor. The island used to house a state penitentiary where the authorities were experimenting on death row inmates and now the bodies won't stay still."
/// yt_trailer_code : "Mr0NM0draJo"
/// language : "en"
/// mpa_rating : ""
/// background_image : "https://yts.lt/assets/images/movies/13_Eerie_2013/background.jpg"
/// background_image_original : "https://yts.lt/assets/images/movies/13_Eerie_2013/background.jpg"
/// small_cover_image : "https://yts.lt/assets/images/movies/13_Eerie_2013/small-cover.jpg"
/// medium_cover_image : "https://yts.lt/assets/images/movies/13_Eerie_2013/medium-cover.jpg"
/// large_cover_image : "https://yts.lt/assets/images/movies/13_Eerie_2013/large-cover.jpg"
/// medium_screenshot_image1 : "https://yts.lt/assets/images/movies/13_Eerie_2013/medium-screenshot1.jpg"
/// medium_screenshot_image2 : "https://yts.lt/assets/images/movies/13_Eerie_2013/medium-screenshot2.jpg"
/// medium_screenshot_image3 : "https://yts.lt/assets/images/movies/13_Eerie_2013/medium-screenshot3.jpg"
/// large_screenshot_image1 : "https://yts.lt/assets/images/movies/13_Eerie_2013/large-screenshot1.jpg"
/// large_screenshot_image2 : "https://yts.lt/assets/images/movies/13_Eerie_2013/large-screenshot2.jpg"
/// large_screenshot_image3 : "https://yts.lt/assets/images/movies/13_Eerie_2013/large-screenshot3.jpg"
/// cast : [{"name":"Jesse Moss","character_name":"Patrick","url_small_image":"https://yts.lt/assets/images/actors/thumb/nm1536605.jpg","imdb_code":"1536605"},{"name":"Katharine Isabelle","character_name":"Megan","url_small_image":"https://yts.lt/assets/images/actors/thumb/nm0410622.jpg","imdb_code":"0410622"},{"name":"Brendan Fletcher","character_name":"Josh","url_small_image":"https://yts.lt/assets/images/actors/thumb/nm0281956.jpg","imdb_code":"0281956"},{"name":"Shannon Jardine","character_name":"Skinhead Nazi Zombie","imdb_code":"1266084"}]
/// torrents : [{"url":"https://yts.lt/torrent/download/9E74E644A45E1A7F5520ED6C046410A1E733ADFB","hash":"9E74E644A45E1A7F5520ED6C046410A1E733ADFB","quality":"720p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"698.43 MB","size_bytes":732356936,"date_uploaded":"2019-07-26 15:57:07","date_uploaded_unix":1564149427},{"url":"https://yts.lt/torrent/download/B423E5BDFAC29096C11015DAA72401C769FFCA10","hash":"B423E5BDFAC29096C11015DAA72401C769FFCA10","quality":"1080p","type":"bluray","is_repack":"0","video_codec":"x264","bit_depth":"8","audio_channels":"2.0","seeds":0,"peers":0,"size":"1.24 GB","size_bytes":1331439862,"date_uploaded":"2015-10-31 20:46:54","date_uploaded_unix":1446320814}]
/// date_uploaded : "2019-07-26 15:57:07"
/// date_uploaded_unix : 1564149427

class MovieDetailsDto {
  MovieDetailsDto({
      this.id, 
      this.url, 
      this.imdbCode, 
      this.title, 
      this.titleEnglish, 
      this.titleLong, 
      this.slug, 
      this.year, 
      this.rating, 
      this.runtime, 
      this.genres, 
      this.likeCount, 
      this.descriptionIntro, 
      this.descriptionFull, 
      this.ytTrailerCode, 
      this.language, 
      this.mpaRating, 
      this.backgroundImage, 
      this.backgroundImageOriginal, 
      this.smallCoverImage, 
      this.mediumCoverImage, 
      this.largeCoverImage, 
      this.mediumScreenshotImage1, 
      this.mediumScreenshotImage2, 
      this.mediumScreenshotImage3, 
      this.largeScreenshotImage1, 
      this.largeScreenshotImage2, 
      this.largeScreenshotImage3, 
      this.cast, 
      this.dateUploaded,
      this.dateUploadedUnix,});

  MovieDetailsDto.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating = json['rating'];
    runtime = json['runtime'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    likeCount = json['like_count'];
    descriptionIntro = json['description_intro'];
    descriptionFull = json['description_full'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    mediumScreenshotImage1 = json['medium_screenshot_image1'];
    mediumScreenshotImage2 = json['medium_screenshot_image2'];
    mediumScreenshotImage3 = json['medium_screenshot_image3'];
    largeScreenshotImage1 = json['large_screenshot_image1'];
    largeScreenshotImage2 = json['large_screenshot_image2'];
    largeScreenshotImage3 = json['large_screenshot_image3'];
    if (json['cast'] != null) {
      cast = [];
      json['cast'].forEach((v) {
        cast?.add(Cast.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  num? year;
  num? rating;
  num? runtime;
  List<String>? genres;
  num? likeCount;
  String? descriptionIntro;
  String? descriptionFull;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? mediumScreenshotImage1;
  String? mediumScreenshotImage2;
  String? mediumScreenshotImage3;
  String? largeScreenshotImage1;
  String? largeScreenshotImage2;
  String? largeScreenshotImage3;
  List<Cast>? cast;
  String? dateUploaded;
  num? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['like_count'] = likeCount;
    map['description_intro'] = descriptionIntro;
    map['description_full'] = descriptionFull;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['medium_screenshot_image1'] = mediumScreenshotImage1;
    map['medium_screenshot_image2'] = mediumScreenshotImage2;
    map['medium_screenshot_image3'] = mediumScreenshotImage3;
    map['large_screenshot_image1'] = largeScreenshotImage1;
    map['large_screenshot_image2'] = largeScreenshotImage2;
    map['large_screenshot_image3'] = largeScreenshotImage3;
    if (cast != null) {
      map['cast'] = cast?.map((v) => v.toJson()).toList();
    }

    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }

  MovieDetailsEntity toMovieDetails() {
    return MovieDetailsEntity(
      id: id,
      title: title,
      titleLong: titleLong,
      year: year?.toInt(),
      rating: rating?.toDouble(),
      runtime: runtime?.toInt(),
      genres: genres,

      description: descriptionFull ?? descriptionIntro,
      trailerCode: ytTrailerCode,

      backgroundImage: backgroundImageOriginal ?? backgroundImage,
      coverImage: largeCoverImage ?? mediumCoverImage ?? smallCoverImage,

      screenshots: [
        mediumScreenshotImage1,
        mediumScreenshotImage2,
        mediumScreenshotImage3,
      ].whereType<String>().toList(),

      cast: cast?.map((castItem) => MovieCastEntity(
          name: castItem.name ?? '',
          characterName: castItem.characterName ?? '',
          image: castItem.urlSmallImage,
        ),
      ).toList() ?? [],
    );
  }
}

/// url : "https://yts.lt/torrent/download/9E74E644A45E1A7F5520ED6C046410A1E733ADFB"
/// hash : "9E74E644A45E1A7F5520ED6C046410A1E733ADFB"
/// quality : "720p"
/// type : "bluray"
/// is_repack : "0"
/// video_codec : "x264"
/// bit_depth : "8"
/// audio_channels : "2.0"
/// seeds : 0
/// peers : 0
/// size : "698.43 MB"
/// size_bytes : 732356936
/// date_uploaded : "2019-07-26 15:57:07"
/// date_uploaded_unix : 1564149427



/// name : "Jesse Moss"
/// character_name : "Patrick"
/// url_small_image : "https://yts.lt/assets/images/actors/thumb/nm1536605.jpg"
/// imdb_code : "1536605"

class Cast {
  Cast({
      this.name, 
      this.characterName, 
      this.urlSmallImage, 
      this.imdbCode,});

  Cast.fromJson(dynamic json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }
  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['character_name'] = characterName;
    map['url_small_image'] = urlSmallImage;
    map['imdb_code'] = imdbCode;
    return map;
  }

}