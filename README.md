<p class="text-align: center; color: red;">
    This project is a work in progress and is not ready for production use.<br />
    Update may and will break compatibility with previous versions.
</p>

A library destined to work with Danbooru based image boards. Using the [http] package to provide a fast and  modular way to interact with the API.

## Features

- All endpoints from the palm of your hand.
- Easy to use and understand.
- Authentication support.
- Customizable and modular.

## Getting started

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  danbooru: ^0.0.1
```

Then run `pub get` or `flutter pub get` to install the package.


## Usage

```dart
import 'package:danbooru/danbooru.dart';

void main() async {
  final client = DanbooruClient();

  final posts = await client.posts.list(limit: 5);

  for (final post in posts) {
    print(post.fileUrl);
  }
}
``` 

## Additional information

### Legal notice

This project is not affiliated with Danbooru or any of its partners. The use of this library is at your own risk.

### License

PROJETRETRO RESTRICTED LICENSE + AI (PRL + AI)

[license@projetretro.io](license@projetretro.io) - 2024

This license cover both the use of the project itself and the use or any parts of the code and/or assets composing the project to which this license is attached in any fashion.

The product to which this license is granted is distributed "AS IS" and without any warranty of any kind, express or implied.
The user and/or provider of the product to an end user assumes all risk of user, damage or injury.
The user and/or provider of the product to an end user is solely responsible for determining the suitability of this product ofr it's intended use.

By using the product attached to this license, the user and/or provider of the product to an end user agrees to the terms of this license.
If you do not agree to all the terms of this license, do not use the product.

This license is RESTRICTIVE, it's mean that any usage EXPRESSLY not authorized by said license is FORBIDDEN.

You must :
- Provide a complete copy of this license with any distribution of the product
- Not remove any copyright, trademark or patent notices from the product or any parts
- Provide an updated version of the license with any modification of the product AS SOON AS POSSIBLE and CLEARLY NOTIFY the user of the modification

It's EXPRESSLY FORBIDDEN to :
- Re-license the project or any parts under any others licenses
- Use the project or any parts for any commercial (meaning generating revenue) purposes WITHOUT written authorization from the project owner
    - Open source projects donations are excluded from this restriction
- Use the project or any parts of the code and/or assets composing the project to which this license is attached in any fashion to train, generate, feed or any kind of action related to LLM or any AI related technologies


Failing to comply to the license term in a deliberate way will result in the immediate termination of the license and a fee of 1% of the total revenue generated by the product using the project to which this license is attached in any fashion to the author(s) of the project and/or legal actions.


