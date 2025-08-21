# E‑Commerce App (Flutter)

Simple, multi-platform e‑commerce sample built with Flutter and Provider. It includes onboarding, authentication, a product catalog, a cart, and a profile screen.

## Features

- Intro screen with app branding
- Authentication
	- Login and Signup screens
	- Show/Hide password toggles
- Dashboard with bottom navigation (google_nav_bar)
	- Shop (Deals list)
	- Cart (items added by the user)
	- Profile (shows signup details, sign out)
- State management via Provider
	- `Cart` manages products and cart items
	- `UserProfile` stores basic user details (name, email)

## Tech Stack

- Flutter 3.x (Dart 3.x)
- Packages: `provider`, `google_nav_bar`, `cupertino_icons`

## Project structure

```
lib/
	main.dart                    # App entry, routes, providers
	components/
		nav.dart                   # Bottom navigation (GNav)
		card.dart                  # Product card/tile
	models/
		shoe.dart                  # Product model
		cart.dart                  # Cart provider (shop items + user cart)
		user.dart                  # UserProfile provider (name/email)
	pages/
		into_page.dart             # Intro/landing
		login.dart                 # Login screen
		signup.dart                # Signup screen
		dash.dart                  # Dashboard with bottom nav
		shop.dart                  # Deals list
		cart.dart                  # Cart page
		profile.dart               # Profile page
	images/                      # App images (configured in pubspec)
```

## Routing

- `/login` → LoginPage
- `/signup` → SignupPage
- `/dash` → Dashboard (tabs: Shop, Cart, Profile)

Initial screen is `IntroPage`, which navigates to Login.

## State management

`MultiProvider` is set up in `main.dart`:

- `Cart` – exposes `getShoeList()`, `getUserCart()`, `addItemToCart()`, `removeItemFromCart()`
- `UserProfile` – exposes `setUser(name, email)` and `signOut()`

## Assets

Assets are configured under `lib/images/` in `pubspec.yaml`:

```yaml
flutter:
	uses-material-design: true
	assets:
		- lib/images/
```

Ensure every image referenced in code exists, for example:

- lib/images/3.png
- lib/images/4.png
- lib/images/5.png

If you see a runtime error like "Unable to load asset: lib/images/6.png", either add that file to `lib/images/` or remove/update the product that references it in `lib/models/cart.dart`.

## Run locally

On Windows PowerShell:

```powershell
flutter pub get
flutter run
```

When prompted, select a device (Windows/Chrome/Edge, etc.).

## Useful tips

- Hot reload: press `r` in the run console
- Hot restart: press `R`
- To sign out, use the button on the Profile page (it clears the `UserProfile` and returns to Login)

## Next steps (ideas)

- Connect to a backend for real authentication
- Persist cart and user session (e.g., shared_preferences)
- Product details page and checkout flow
- Form validation and error messages on auth

## License

MIT (or choose your license)
