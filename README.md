# Multi Ads Flutter App

A Flutter application that demonstrates multi-ad network integration with support for Google AdMob and AppLovin MAX. The app showcases various ad formats including banner, interstitial, rewarded, native, and open ads.

## 🚀 Features

- **Multi-Ad Network Support**: Seamlessly switch between Google AdMob and AppLovin MAX
- **Multiple Ad Formats**:
  - Banner Ads
  - Interstitial Ads
  - Rewarded Video Ads
  - Native Ads
  - Open Ads (App Open Ads)
- **Dynamic Configuration**: Remote configuration loading from JSON
- **App Lifecycle Management**: Proper ad lifecycle handling
- **Error Handling**: Robust error handling with retry mechanisms
- **Modern UI**: Clean, modern interface with Material Design 3

## 📱 Screenshots

The app includes:
- Loading screen with configuration fetching
- Main screen with ad demonstration buttons
- Native and banner ad displays

## 🛠️ Installation

### Prerequisites

- Flutter SDK (3.5.3 or higher)
- Android Studio / Xcode for platform-specific development
- Google AdMob account
- AppLovin MAX account (optional)

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd multi_ads_ali
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Ad Networks**

   #### Google AdMob Setup
   - Create an AdMob account at [admob.google.com](https://admob.google.com)
   - Create ad units for your app
   - Update the configuration JSON with your AdMob ad unit IDs

   #### AppLovin MAX Setup
   - Create an AppLovin account at [applovin.com](https://applovin.com)
   - Create an app and get your SDK key
   - Update the configuration JSON with your AppLovin settings

4. **Update Configuration**
   
   The app loads configuration from a remote JSON file. Update the URL in `lib/const.dart`:
   ```dart
   static const jsonConfigUrl = 'YOUR_CONFIG_JSON_URL';
   ```

   Your configuration JSON should include:
   ```json
   {
     "ads": {
       "admob": {
         "openAdsIds": "ca-app-pub-3940256099942544/9257395921",
         "bannerIds": ["ca-app-pub-3940256099942544/9214589741"],
         "interIds": ["ca-app-pub-3940256099942544/1033173712"],
         "nativeIds": ["ca-app-pub-3940256099942544/2247696110"],
         "rewardIds": ["ca-app-pub-6503755592272111/5763890191"]
       },
       "applovin": {
         "sdk_key": "",
         "bannerId": "",
         "openAdsIds": "60bcaa3bee8f034b",
         "interId": "40a9b25969e5e629",
         "nativeId": "43e21bcddec13181",
         "rewardId": "42fda58804fc7b6c"
       },
       "settings": {
         "openads": "admob",
         "banners": "admob",
         "inters": "admob",
         "natives": "admob",
         "rewards": "admob"
       }
     }
   }
   ```

## 🎯 Usage

### Basic Implementation

1. **Initialize the ads system** (done automatically in `LoadingScreen`):
   ```dart
   gAds = MultiAds(configJson);
   await gAds.init();
   await gAds.loadAds();
   ```

2. **Show different ad types**:
   ```dart
   // Banner Ad
   CustomBanner(
     key: const ValueKey('banner_ad'),
     ads: gAds.bannerInstance,
   )
   
   // Interstitial Ad
   gAds.interInstance.showInterstitialAd();
   
   // Rewarded Ad
   gAds.rewardInstance.showRewardAd(() {
     // Reward callback
   });
   
   // Native Ad
   CustomNative(
     key: const ValueKey('native_ad'),
     ads: gAds.nativeInstance,
     templateType: TemplateType.medium,
   )
   
   // Open Ad
   gAds.openAdsInstance.showAdIfAvailableOpenAds();
   ```

### App Lifecycle Integration

The app includes proper lifecycle management to handle ad states when the app goes to background/foreground:

```dart
class _MyAppState extends State<MyApp> {
  final _lifecycleObserver = AppLifecycleObserver();

  @override
  void initState() {
    super.initState();
    _lifecycleObserver.initialize();
  }

  @override
  void dispose() {
    _lifecycleObserver.dispose();
    super.dispose();
  }
}
```


### Ad Unit IDs

Each ad network requires specific ad unit IDs. Make sure to:

1. Use test ad unit IDs during development
2. Replace with production ad unit IDs before release
3. Ensure ad unit IDs match the correct ad format

## 🚀 Building for Production

### iOS

1. Update `ios/Runner/Info.plist` with your AdMob App ID
2. Replace test ad unit IDs with production IDs
3. Build the iOS app:
   ```bash
   flutter build ios --release
   ```

## 📋 Dependencies

- `flutter`: SDK
- `google_mobile_ads: ^6.0.0`: Google AdMob integration
- `applovin_max: ^4.5.2`: AppLovin MAX integration
- `http: ^1.5.0`: HTTP requests for configuration

## 🐛 Troubleshooting

### Common Issues

1. **Ads not showing**:
   - Check your ad unit IDs
   - Ensure you're using test ad unit IDs during development
   - Verify network connectivity
   - Check ad network account status

2. **Configuration loading fails**:
   - Verify the JSON configuration URL is accessible
   - Check JSON format validity
   - Ensure proper CORS headers if hosting on a web server

3. **Build errors**:
   - Run `flutter clean` and `flutter pub get`
   - Check Flutter and Dart SDK versions
   - Verify platform-specific configurations

### Debug Mode

Enable debug logging by checking the console output. The app includes comprehensive logging for ad events and errors.

4. **Open Ads not showing**:
   - Ensure you call `loadAppOpenAd()` before `showAdIfAvailableOpenAds()`
   - Wait for the ad to load before attempting to show it
   - Check that the app is in the foreground when showing open ads

## 📄 License

This project is for educational and demonstration purposes. Make sure to comply with the terms of service of the ad networks you're using.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📞 Support

For issues and questions:
- Check the troubleshooting section
- Review ad network documentation
- Open an issue in the repository

---

**Note**: This is a demonstration app. Make sure to follow best practices for ad implementation in production apps, including proper user consent, ad placement guidelines, and compliance with app store policies.
