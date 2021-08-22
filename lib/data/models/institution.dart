// To parse this JSON data, do
//
//     final institution = institutionFromJson(jsonString);

import 'dart:convert';

Institution institutionFromJson(String str) => Institution.fromJson(json.decode(str));

String institutionToJson(Institution data) => json.encode(data.toJson());

class Institution {
    Institution({
        this.name,
        this.telephone,
        this.logo,
        this.email,
        this.address,
        this.websiteUrl,
    });

    String name;
    String telephone;
    String logo;
    String email;
    String address;
    String websiteUrl;

    factory Institution.fromJson(Map<String, dynamic> json) => Institution(
        name: json["name"],
        telephone: json["telephone"],
        logo: json["logo"],
        email: json["email"],
        address: json["address"],
        websiteUrl: json["website_url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "telephone": telephone,
        "logo": logo,
        "email": email,
        "address": address,
        "website_url": websiteUrl,
    };
}
