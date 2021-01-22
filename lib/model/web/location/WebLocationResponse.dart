class WebLocationResponse {
  String countryCode;
  String countryName;
  String city;
  String postal;
  double latitude;
  double longitude;
  String iPv4;
  String state;

  WebLocationResponse(
      {this.countryCode,
        this.countryName,
        this.city,
        this.postal,
        this.latitude,
        this.longitude,
        this.iPv4,
        this.state});

  WebLocationResponse.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    countryName = json['country_name'];
    city = json['city'];
    postal = json['postal'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    iPv4 = json['IPv4'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['country_name'] = this.countryName;
    data['city'] = this.city;
    data['postal'] = this.postal;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['IPv4'] = this.iPv4;
    data['state'] = this.state;
    return data;
  }
}
