import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/datasource/local_data/preference_manager.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotify {
  XFile? selectedImage;
  String userName = '';
  String? countryCode;
  String? countryName;

  Future<void> pickImage(ImageSource source) async {
    selectedImage = await ImagePicker().pickImage(source: source);
    // saveImage();
    safeNotify();
  }

  void getUserName() {
    userName = PreferencesManager().getString('user_name') ?? '';
    countryCode = PreferencesManager().getString('country_code');
    countryName = PreferencesManager().getString('country_name');
    safeNotify();
  }

  void saveCountry(Country selectedCountry) async {
    await PreferencesManager().setString('country_code', selectedCountry.countryCode);
    await PreferencesManager().setString('country_name', selectedCountry.name);
    countryCode = selectedCountry.countryCode;
    countryName = selectedCountry.name;
    safeNotify();
  }
}
