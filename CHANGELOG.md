## 2.0.0

- **Breaking change**. Gradle 4.0+ is needed on Android. 
- Added support for dart null sound safety

## 1.0.8

- Update Android Plugin
- Fix unable to default to .env

## 1.0.7

- Add method for tests

## 1.0.6

- **Breaking change**. reading the envfile has been moved from /tmp/envfile
  to the root project directory. you need to change your pre-action scripts from
  `echo ".env" > /tmp/envfile ` to `echo ".env" > ${SRCROOT}/.envfile`

* Update documentation for iOS
* Fix Product name

## 1.0.5

- Update documentation for iOS

## 1.0.4

- Use a singleton pattern for FlutterConfig class
- Add some notes to iOS readme.

## 1.0.3

- Use the latest Gradle and Kotlin verision

## 1.0.2

- Improve Documentation and example

## 1.0.1

- Add support for numbers in Android Build Flavors
- Fix - Allowing urls in xcconfig for iOS

## 1.0.0

- Clean up logs
- Add Documetation

## 0.0.1

- Initial version
