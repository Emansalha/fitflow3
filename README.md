# FitFlow – Flutter fitness & nutrition app

## Run
```bash
flutter create fitflow --platforms=android,ios
# copy this project's `lib/` folder and `pubspec.yaml` over the generated ones
cd fitflow
flutter pub get
flutter run
```
No third-party packages are used. Rings and charts are drawn with `CustomPainter`.
Replace the gradient `WorkoutArt` boxes with `Image.asset(...)` when you have real photos.

## Structure
- `lib/core` theme, glass widgets, painters
- `lib/models` workout data
- `lib/screens` onboarding, home, workouts, workout detail, activity, nutrition

## Real photos and videos
1. Put files in `assets/images/` and `assets/videos/` (or use https links).
2. Open `lib/models/workout.dart` and fill the optional fields, e.g.
   `Workout(..., image: 'assets/images/full_body.jpg', video: 'assets/videos/full_body.mp4')`
   and `Exercise('Goblet Squat', '3 sets x 12 reps', 'assets/videos/goblet_squat.mp4')`.
3. Hero photo on the first screen: set `kOnboardingImage`.
4. Android release builds need internet permission for web media: add
   `<uses-permission android:name="android.permission.INTERNET"/>` to
   `android/app/src/main/AndroidManifest.xml`. iOS needs https links (or an ATS exception).

Free sources with commercial licenses: Pexels, Pixabay, Unsplash (photos); Pexels and Pixabay (videos).
Check each item's license, and prefer bundling files in `assets/` over hot-linking.

## Ads page (before the app starts)
The app now opens on `lib/screens/ads_screen.dart`: 3 swipeable ads, auto-advance, Skip and Next buttons.
To change the ads, edit `lib/models/ad.dart`:
1. Put your images (recommended 1080x1350 px) in `assets/ads/`.
2. Set `image: 'assets/ads/ad1.jpg'` (or an https link) for each `AdItem`, and edit its title and subtitle.
3. Add or remove items, or change `kAdSeconds`. An empty list skips the page.
