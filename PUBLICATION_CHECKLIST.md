# Publication Checklist for Enhanced Split View

Use this checklist before publishing to pub.dev.

## Pre-Publication Checklist

### Code Quality
- [x] All critical bugs fixed (animation improved with AnimatedSize)
- [x] Code follows Dart style guidelines
- [x] No `print` statements (using `debugPrint`)
- [x] All analyzer warnings resolved
- [x] Code is properly formatted (`dart format .`)

### Testing
- [x] All existing tests pass (`flutter test`)
- [x] New tests added for edge cases
- [x] Test coverage is adequate (20+ test cases)
- [ ] Manual testing on multiple platforms (iOS, Android, Web, Desktop)

### Documentation
- [x] README.md is complete and accurate
- [x] All public APIs have dartdoc comments
- [x] Examples are working and up-to-date
- [x] CHANGELOG.md is updated
- [x] LICENSE file is present (MIT)
- [x] CONTRIBUTING.md is present

### Package Configuration
- [x] `pubspec.yaml` has correct version number (1.0.0)
- [x] `pubspec.yaml` has real GitHub URLs (replace YOUR_GITHUB_USERNAME)
- [x] `pubspec.yaml` has proper description (60-180 chars)
- [ ] `pubspec.yaml` has homepage, repository, issue_tracker URLs
- [x] SDK constraints are correct (`sdk: ^3.9.2`)
- [x] Dependencies are minimal (zero - excellent!)

### Repository Setup
- [ ] GitHub repository is created
- [ ] Repository is public
- [ ] `.gitignore` is configured
- [ ] Initial commit is pushed
- [ ] README displays correctly on GitHub
- [ ] Release tag v1.0.0 is created

### Assets & Media
- [ ] Screenshots are added to README (optional for v1.0.0, recommended for v1.1.0)
- [ ] GIFs/videos of examples (optional but recommended)
- [x] Example app is in `example/` directory
- [x] Example app runs without errors

### Legal & Metadata
- [x] License file includes your name (Kapil Agarwal)
- [x] Copyright year is correct (2025)
- [ ] Package name is available on pub.dev (check manually)
- [x] Package follows pub.dev naming conventions

## Commands to Run

```bash
# 1. Format code
dart format .

# 2. Run analyzer
flutter analyze

# 3. Run tests
flutter test

# 4. Run tests with coverage
flutter test --coverage

# 5. Verify package structure
flutter pub publish --dry-run

# 6. Build example (verify it works)
cd example
flutter build apk  # Android
flutter build web  # Web
cd ..

# 7. Run pre-publish script
chmod +x pre_publish_check.sh
./pre_publish_check.sh
```

## Manual Checks

### Before Creating GitHub Repo
- [ ] Choose GitHub username
- [ ] Decide on repository name (recommended: enhanced_split_view)

### After Creating GitHub Repo
- [ ] Replace ALL instances of YOUR_GITHUB_USERNAME in:
    - [ ] pubspec.yaml
    - [ ] README.md
    - [ ] CHANGELOG.md
    - [ ] GITHUB_SETUP.md

### Package Name Availability
- [ ] Visit https://pub.dev/packages/enhanced_split_view
- [ ] Confirm package name is available
- [ ] If taken, choose alternative name

### Screenshots (Optional but Recommended)
Add screenshots showing:
- [ ] Basic 2-pane split
- [ ] 3-pane split with live resizing
- [ ] Vertical split
- [ ] Custom styling
- [ ] IDE layout example

Recommended image specs:
- Format: PNG or GIF
- Size: 800-1200px wide
- Quality: High (but compressed <500KB each)
- Location: `screenshots/` directory in repo

## Publication Steps

### 1. Create GitHub Repository
Follow instructions in GITHUB_SETUP.md

### 2. Update URLs
```bash
# Search for placeholders
grep -r "YOUR_GITHUB_USERNAME" .
grep -r "YOUR_USERNAME" .

# Replace with your actual username
# Use find-and-replace in your editor
```

### 3. Verify Everything
```bash
# Run the pre-publish script
./pre_publish_check.sh

# Review output carefully
```

### 4. Dry Run
```bash
flutter pub publish --dry-run
```

Review the output:
- Check pub points score (aim for 130+)
- Verify all sections are green
- Fix any warnings or errors

### 5. Final Manual Review
- [ ] Read through README.md on GitHub
- [ ] Test example app on at least 2 platforms
- [ ] Verify all links work
- [ ] Check that documentation is clear

### 6. Create GitHub Release
1. Go to your repository on GitHub
2. Click "Releases" → "Create a new release"
3. Tag: `v1.0.0`
4. Title: `Enhanced Split View 1.0.0`
5. Description: Copy from CHANGELOG.md
6. Click "Publish release"

### 7. Publish to pub.dev
```bash
flutter pub publish
```

When prompted:
- Review the package contents
- Type 'y' to confirm
- Wait for upload to complete

### 8. Post-Publication (within 24 hours)
- [ ] Verify package appears on pub.dev
- [ ] Check package score after a few hours
- [ ] Test installation in a new project:
  ```bash
  flutter create test_app
  cd test_app
  # Add enhanced_split_view: ^1.0.0 to pubspec.yaml
  flutter pub get
  # Try using it
  ```
- [ ] Monitor GitHub issues for early feedback

### 9. Promotion (Optional)
- [ ] Share on Twitter/X with #FlutterDev
- [ ] Post on Reddit r/FlutterDev
- [ ] Share on LinkedIn
- [ ] Add to Flutter Awesome list
- [ ] Write a blog post about it

## Common Issues to Avoid

### Before Publishing
- ❌ Placeholder URLs still present
- ❌ Package name already taken
- ❌ Tests failing
- ❌ Analyzer warnings
- ❌ Incorrect version number
- ❌ Missing LICENSE or README

### During Publishing
- ❌ Not logged into pub.dev account
- ❌ Package name conflicts with existing package
- ❌ Description too short (<60 chars) or too long (>180 chars)
- ❌ Invalid SDK constraints

### After Publishing
- ❌ Broken links in README
- ❌ Example app doesn't work
- ❌ Missing documentation
- ❌ No response to issues

## Scoring Well on pub.dev

To achieve 130+ pub points:

### Documentation (30 points)
- [x] README with examples
- [x] CHANGELOG
- [x] Example code
- [x] API documentation

### Platform Support (20 points)
- [x] Multi-platform support (Android, iOS, Web, Desktop)
- [x] No platform restrictions

### Package Layout (5 points)
- [x] Proper directory structure
- [x] LICENSE file
- [x] README in package root

### Maintenance (20 points)
- [x] Recent commit activity
- [x] Responds to issues
- [x] Regular updates

### Popularity (Will grow over time)
- Downloads
- Likes
- Pub points from other metrics

## Version History Planning

### v1.0.0 (Current)
- Initial release
- Core features complete

### v1.1.0 (Future - Optional)
- Add keyboard shortcuts
- Add screenshots to README
- Performance optimizations
- Add more examples

### v1.2.0 (Future - Optional)
- Persistence support (save/restore layout)
- Programmable weight updates
- Animation customization
- Min/max size in pixels (not just weights)

## Support Plan

After publishing, plan to:
- Respond to issues within 48 hours
- Review PRs within 1 week
- Release bug fixes within 2 weeks
- Consider feature requests for minor versions

## Contact Information

Package maintainer: Kapil Agarwal
Email: kapilagarwal96@gmail.com

For urgent issues, respond via GitHub issues.

---

**Remember**: Quality over speed. It's better to delay publishing by a day to ensure everything is perfect than to rush and have issues.

Good luck with your publication! 🚀