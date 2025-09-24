import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:multiads/ads/src/widgets/custom_banner.dart';
import 'package:multiads/ads/src/widgets/custom_native.dart';
import 'package:multiads/const.dart';
import 'package:multiads/service/app_lifecycle_observer.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  AppLifecycleObserver _appLifecycleObserver = AppLifecycleObserver();
  @override
  void initState() {
    super.initState();
    // wait 500 ms
    Future.delayed(const Duration(milliseconds: 500), () {
      gAds.openAdsInstance.showAdIfAvailableOpenAds();
    });
  }

  Widget _buildAdButton({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 8,
          shadowColor: color.withOpacity(0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section

            // Ad Buttons Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAdButton(
                      title: 'Show Interstitial Ad',
                      subtitle: 'Full screen ad between content',
                      icon: Icons.fullscreen,
                      onPressed: () {
                        gAds.interInstance.showInterstitialAd();
                      },
                      color: Constants.mainColor,
                    ),
                    const SizedBox(height: 20),
                    _buildAdButton(
                      title: 'Show Rewarded Ad',
                      subtitle: 'Watch ad to earn rewards',
                      icon: Icons.card_giftcard,
                      onPressed: () {
                        gAds.rewardInstance.showRewardAd(() {
                          print('Rewarded ad shown');
                        });
                      },
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 20),
                    _buildAdButton(
                      title: 'Show Open Ad',
                      subtitle: 'Show open ad',
                      icon: Icons.open_in_new,
                      onPressed: () {
                        gAds.openAdsInstance.showAdIfAvailableOpenAds();
                      },
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),

            // Native Ad Section
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Native Advertisement',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomNative(
                    key: const ValueKey('native_ad'),
                    ads: gAds.nativeInstance,
                    templateType: TemplateType.medium,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            // Banner Ad Section
            CustomBanner(
              key: const ValueKey('banner_ad'),
              ads: gAds.bannerInstance,
            ),
          ],
        ),
      ),
    );
  }
}
