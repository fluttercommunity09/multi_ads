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
     "config": {
       "primary_network": "admob",
       "fallback_network": "applovin"
     },
     "admob": {
       "banner_id": "ca-app-pub-xxx/xxx",
       "interstitial_id": "ca-app-pub-xxx/xxx",
       "rewarded_id": "ca-app-pub-xxx/xxx",
       "native_id": "ca-app-pub-xxx/xxx",
       "open_id": "ca-app-pub-xxx/xxx"
     },
     "applovin": {
       "sdk_key": "YOUR_SDK_KEY",
       "banner_id": "YOUR_BANNER_ID",
       "interstitial_id": "YOUR_INTERSTITIAL_ID",
       "rewarded_id": "YOUR_REWARDED_ID",
       "native_id": "YOUR_NATIVE_ID",
       "open_id": "YOUR_OPEN_ID"
     }
   }
   ```

## 🏗️ Project Structure

```
lib/
├── ads/                          # Ad network integration
│   ├── multi_ads.dart           # Main ads export file
│   ├── networks.dart            # Network constants
│   └── src/
│       ├── data/                # Ad configuration data
│       ├── globals/             # Global variables
│       ├── networks/            # Network-specific implementations
│       ├── utils/               # Utility functions
│       ├── widgets/             # Custom ad widgets
│       └── multi_ads_factory.dart
├── const.dart                   # App constants and global variables
├── main.dart                    # App entry point
├── screen/                      # App screens
│   ├── loading.dart            # Loading/configuration screen
│   └── start.dart              # Main demo screen
└── service/
    └── app_lifecycle_observer.dart  # App lifecycle management
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
   CustomBanner(ads: gAds.bannerInstance)
   
   // Interstitial Ad
   gAds.interInstance.showInterstitialAd();
   
   // Rewarded Ad
   gAds.rewardInstance.showRewardAd(() {
     // Reward callback
   });
   
   // Native Ad
   CustomNative(
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

## 🔧 Configuration

### Ad Network Priority

The app supports fallback between ad networks. Configure the primary and fallback networks in your JSON configuration:

```json
{
  "config": {
    "primary_network": "admob",
    "fallback_network": "applovin"
  }
}
```

### Ad Unit IDs

Each ad network requires specific ad unit IDs. Make sure to:

1. Use test ad unit IDs during development
2. Replace with production ad unit IDs before release
3. Ensure ad unit IDs match the correct ad format

## 🚀 Building for Production

### Android

1. Update `android/app/build.gradle` with your signing configuration
2. Replace test ad unit IDs with production IDs
3. Build the APK:
   ```bash
   flutter build apk --release
   ```

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
- `cupertino_icons: ^1.0.8`: iOS-style icons

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
