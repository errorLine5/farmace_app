import 'package:farmace_app/homepage.dart';
import 'package:farmace_app/login.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //get token and email from storage
  String token = '';
  String email = '';
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        token = prefs.getString('token') ?? '';
        email = prefs.getString('email') ?? '';
      });
    });
    SharedPreferences.getInstance().then((value) {
      setState(() {
        isDarkMode = value.getBool('isDarkMode') ?? false;
      });
    });
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      // Save the user's choice in shared preferences
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('isDarkMode', isDarkMode);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xffffffff),
          primaryContainer: Color(0xffffffff),
          secondary: Color(0xff68a2f5),
          secondaryContainer: Color(0xffffdbcf),
          tertiary: Color(0xff006875),
          tertiaryContainer: Color(0xff95f0ff),
          appBarColor: Color(0xffffdbcf),
          error: Color(0xffb00020),
        ),
        appBarStyle: FlexAppBarStyle.primary,
        appBarElevation: 4.0,
        bottomAppBarElevation: 8.0,
        tabBarStyle: FlexTabBarStyle.forAppBar,
        subThemesData: const FlexSubThemesData(
          interactionEffects: false,
          tintedDisabledControls: false,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          adaptiveRemoveElevationTint: FlexAdaptive.all(),
          adaptiveElevationShadowsBack: FlexAdaptive.all(),
          adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),
          defaultRadius: 20.0,
          adaptiveRadius: FlexAdaptive.apple(),
          elevatedButtonSchemeColor: SchemeColor.onPrimary,
          elevatedButtonSecondarySchemeColor: SchemeColor.primary,
          inputDecoratorSchemeColor: SchemeColor.onSurface,
          inputDecoratorBackgroundAlpha: 13,
          inputDecoratorBorderSchemeColor: SchemeColor.primary,
          inputDecoratorUnfocusedBorderIsColored: false,
          fabUseShape: true,
          fabAlwaysCircular: true,
          chipSchemeColor: SchemeColor.primary,
          chipRadius: 20.0,
          popupMenuElevation: 8.0,
          alignedDropdown: true,
          tooltipRadius: 4,
          dialogElevation: 24.0,
          useInputDecoratorThemeInDialogs: true,
          datePickerHeaderBackgroundSchemeColor: SchemeColor.primary,
          snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
          appBarScrolledUnderElevation: 4.0,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
          tabBarIndicatorWeight: 2,
          tabBarIndicatorTopRadius: 0,
          tabBarDividerColor: Color(0x00000000),
          drawerElevation: 16.0,
          drawerWidth: 304.0,
          bottomSheetElevation: 10.0,
          bottomSheetModalElevation: 20.0,
          bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
          bottomNavigationBarElevation: 8.0,
          menuElevation: 8.0,
          menuBarRadius: 0.0,
          menuBarElevation: 1.0,
          navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
          navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
          navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
          navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
          navigationBarIndicatorSchemeColor: SchemeColor.secondary,
          navigationBarBackgroundSchemeColor: SchemeColor.surfaceVariant,
          navigationBarElevation: 0.0,
          navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
          navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
          navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
          navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
          navigationRailIndicatorSchemeColor: SchemeColor.secondary,
        ),
        keyColors: const FlexKeyColors(
          keepPrimary: true,
        ),
        tones: FlexTones.highContrast(Brightness.light),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xff000000),
          primaryContainer: Color(0xff008391),
          secondary: Color(0xff000000),
          secondaryContainer: Color(0xffb6b6b6),
          tertiary: Color(0xffffb779),
          tertiaryContainer: Color(0xff004e59),
          appBarColor: Color(0xffb6b6b6),
          error: Color(0xffcf6679),
        ),
        appBarStyle: FlexAppBarStyle.material,
        appBarElevation: 4.0,
        bottomAppBarElevation: 8.0,
        tabBarStyle: FlexTabBarStyle.forAppBar,
        subThemesData: const FlexSubThemesData(
          interactionEffects: false,
          tintedDisabledControls: false,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
          adaptiveElevationShadowsBack: FlexAdaptive.all(),
          adaptiveAppBarScrollUnderOff: FlexAdaptive.all(),
          defaultRadius: 20.0,
          adaptiveRadius: FlexAdaptive.apple(),
          elevatedButtonSchemeColor: SchemeColor.onPrimary,
          elevatedButtonSecondarySchemeColor: SchemeColor.primary,
          inputDecoratorSchemeColor: SchemeColor.onSurface,
          inputDecoratorBackgroundAlpha: 20,
          inputDecoratorBorderSchemeColor: SchemeColor.primary,
          inputDecoratorUnfocusedBorderIsColored: false,
          fabUseShape: true,
          fabAlwaysCircular: true,
          chipSchemeColor: SchemeColor.primary,
          chipRadius: 20.0,
          popupMenuElevation: 8.0,
          alignedDropdown: true,
          tooltipRadius: 4,
          dialogElevation: 24.0,
          useInputDecoratorThemeInDialogs: true,
          datePickerHeaderBackgroundSchemeColor: SchemeColor.primary,
          snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
          appBarScrolledUnderElevation: 4.0,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
          tabBarIndicatorWeight: 2,
          tabBarIndicatorTopRadius: 0,
          tabBarDividerColor: Color(0x00000000),
          drawerElevation: 16.0,
          drawerWidth: 304.0,
          bottomSheetElevation: 10.0,
          bottomSheetModalElevation: 20.0,
          bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
          bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
          bottomNavigationBarElevation: 8.0,
          menuElevation: 8.0,
          menuBarRadius: 0.0,
          menuBarElevation: 1.0,
          navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
          navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
          navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
          navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
          navigationBarIndicatorSchemeColor: SchemeColor.secondary,
          navigationBarBackgroundSchemeColor: SchemeColor.surfaceVariant,
          navigationBarElevation: 0.0,
          navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
          navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
          navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
          navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
          navigationRailIndicatorSchemeColor: SchemeColor.secondary,
        ),
        keyColors: const FlexKeyColors(
          keepPrimary: true,
          keepSecondary: true,
          keepPrimaryContainer: true,
          keepSecondaryContainer: true,
          keepTertiaryContainer: true,
        ),
        tones: FlexTones.highContrast(Brightness.dark),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),

      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,

      home: token == ''
          ? Login(toggleTheme: toggleTheme)
          : Homepage(
              toggleTheme: toggleTheme,
            ),
    );
  }
}
