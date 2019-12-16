/// данные города
/// для получения прогноза важно - [woeid]
class City {
    final String lattAndLong;
    final String locationType;
    final String title;
    final int woeid;

    City({this.lattAndLong, this.locationType, this.title, this.woeid});

    static fromJson(dynamic json) {
        return City(
            lattAndLong: json['latt_long'],
            locationType: json['location_type'],
            title: json['title'],
            woeid: json['woeid'],
        );
    }
}