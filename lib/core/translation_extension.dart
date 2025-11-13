import 'package:flutter/widgets.dart';
import '../l10n/app_localizations.dart';

extension TrX on BuildContext {
  String tr(String key) {
    final loc = AppLocalizations.of(this);
    if (loc == null) return key;

    switch (key) {
      case "find_your_next_favorite_movie_here":
        return loc.find_your_next_favorite_movie_here;
      case "get_access_to_a_huge":
        return loc.get_access_to_a_huge;
      case "discover_movies":
        return loc.discover_movies;
      case "explore_a_vast_collection":
        return loc.explore_a_vast_collection;
      case "explore_all_genres":
        return loc.explore_all_genres;
      case "discover_movies_from_every_genre":
        return loc.discover_movies_from_every_genre;
      case "create_Watchlists":
        return loc.create_Watchlists;
      case "save_movies_to_your_watchlist_to_keep":
        return loc.save_movies_to_your_watchlist_to_keep;
      case "rate_review_and_learn":
        return loc.rate_review_and_learn;
      case "share_your_thoughts_on_the_movies":
        return loc.share_your_thoughts_on_the_movies;
      case "start_Watching_now":
        return loc.start_Watching_now;
      case "back":
        return loc.back;
      case "finish":
        return loc.finish;
      case "explore_now":
        return loc.explore_now;
      case "next":
        return loc.next;
      case "email":
        return loc.email;
      case "password":
        return loc.password;
      case "login":
        return loc.login;
      case "forget_password":
        return loc.forget_password;
      case "dont_have_account":
        return loc.dont_have_account;
      case "create_one":
        return loc.create_one;
      case "or":
        return loc.or;
      case "login_with_google":
        return loc.login_with_google;
      case "register":
        return loc.register;
      case "avatar":
        return loc.avatar;
      case "name":
        return loc.name;
      case "confirmPassword":
        return loc.confirmPassword;
      case "phoneNumber":
        return loc.phoneNumber;
      case "createAccount":
        return loc.createAccount;
      case "alreadyHaveAccount":
        return loc.alreadyHaveAccount;


      case "name_required":
        return loc.name_required;
      case "name_short":
        return loc.name_short;
      case "email_required":
        return loc.email_required;
      case "email_invalid":
        return loc.email_invalid;
      case "password_required":
        return loc.password_required;
      case "password_short":
        return loc.password_short;
      case "password_weak":
        return loc.password_weak;
      case "confirm_required":
        return loc.confirm_required;
      case "confirm_not_match":
        return loc.confirm_not_match;
      case "phone_required":
        return loc.phone_required;
      case "phone_invalid":
        return loc.phone_invalid;

      default:
        return key;
    }
  }
}
