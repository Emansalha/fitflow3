/// ADS: edit this list to change the 3 ads shown before the app starts.
///
/// `image` can be:
///   - a bundled file:  'assets/ads/ad1.jpg'   (put the file in assets/ads/)
///   - a web link:      'https://example.com/ad1.jpg'
///   - null:            shows a colored placeholder with the text only
///
/// Recommended image size: 1080 x 1350 px (4:5), JPG or PNG.
/// Add or remove items freely. An empty list skips the ads page.
class AdItem {
  const AdItem({required this.title, required this.subtitle, this.image});
  final String title;
  final String subtitle;
  final String? image;
}

const kAds = <AdItem>[
  AdItem(
    title: 'Elite Gym & Fitness',
    subtitle: 'Achieve your peak performance with professional training',
    image: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=1080&auto=format&fit=crop',
  ),
  AdItem(
    title: 'Pro Strength Training',
    subtitle: 'Push your limits and build real muscle mass',
    image: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=1080&auto=format&fit=crop',
  ),
  AdItem(
    title: 'Transform Your Body',
    subtitle: 'Reach your fitness goals with expert guidance',
    image: 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?q=80&w=1080&auto=format&fit=crop',
  ),
];

/// Seconds each ad stays on screen before moving to the next one.
const kAdSeconds = 4;
