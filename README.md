<p align="center">
    <h1 align="center">SafeAlert 🚨</h1>
  </a>
</p>

<p align="center">
    <img src="https://i.ibb.co/3kRpTnt/image-10.jpg" alt="ava" border="0" width="300px">
</p>
<!-- Here is app icon placeholder -->

> SafeAlert - A mobile app designed to deliver prompt assistance from volunteers nearby, providing effective solutions for unexpected incidents.

This project will join [GDSC Solution Challenge 2024](https://developers.google.com/community/gdsc-solution-challenge).

## Technology used ✨

-   [Flutter & Dart](https://flutter.dev/)
-   [Google Map Platform](https://mapsplatform.google.com/)
-   [Firebase](https://firebase.google.com/)
-   [NodeJs](https://nodejs.org/en)

</details>

## Setup and run

<details>
    <summary>Click to expand</summary>
    <br>    
    <h3>Clone the repo</h3>

```sh
git clone https://github.com/dscdut/safe-alert
```

   <h3>Backend</h3>

1. Prerequisites

-   Install node
    <https://nodejs.org/en/download/>

-   Install yarn

```sh
npm install --global yarn
```

2. Install NPM packages

```sh
cd backend
# run database migrations and seeds
npm run db:reset
yarn install
```

3. Run the development server:

```bash
yarn start
```

4. Open [http://localhost:3000](http://localhost:3000).

 <h3>Mobile</h3>
  
 1. Change directory:
  
 ```bash
  cd ..
  cd mobile
 ```
  
 2. Get the dependencies:
  
 ```bash
 flutter pub get
 ```
  
 3. Start build APK release file:
  
 ```bash
 flutter build apk --release -t lib/main_staging.dart --flavor=staging
 ```

<!-- - Download APK
  - [APK - arm64](https://drive.google.com/file/d/1r5BxLCoTn2JqQuEjAtoUxmZeSHIByEKa/view?usp=sharing)
- Setup and run
  - Flutter
    - Install [Flutter](https://flutter.dev/docs/get-started/install).
    - Using **`stable`** channel:
      ```bash
      ❯ flutter channel stable
      ❯ flutter upgrade
      ```
    - Flutter doctor:
      ```bash
      ❯ flutter doctor
      ```
    - Install all the packages by:
      ```bash
      ❯ flutter pub get
      ```
    - Create .env file `assets/.env` has following structure:
      ```bash
      BASE_URL=https://api.smartfood.cooking/api
      ```
    - Run app on real devices or emulator by:
      ```bash
      ❯ flutter run
      ```
      or debug mode in VSCode or some IDEs -->

</details>
