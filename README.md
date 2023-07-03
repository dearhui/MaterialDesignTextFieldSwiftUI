# SwiftUI Material Design Text Field

This project is a custom SwiftUI `TextField` that mimics the style of Material Design.

## Features

The `MaterialTextField` has the following features:

1. Supports both dark mode and light mode.
2. Allows a leading icon and a trailing icon.
3. Provides an eye button for password fields to toggle the visibility of the password.
4. Supports input hints.
5. Supports input validation: If the input does not meet the requirements, the border turns pink.
6. When the user enters content, the label moves to the top and becomes smaller.

## Usage

First, create a `MaterialTextField` and provide a name (for displaying the label) and a bound `String` (for storing and updating the entered content). You can also provide a boolean value indicating whether this field should be a password field.

you can use several modifiers, for example:

```swift
MaterialTextField(name: "Password", value: $password)
    .leadingIcon(Image(systemName: "lock"))
    .isSecured($isSecured)
    .hint("Please enter your password")
```

The above code will create a password field with a lock icon, and provide an eye button for showing and hiding the password, as well as a hint for the input.

You can use these modifiers freely as you need. For example, you may choose to only use the `leadingIcon` modifier without the `isSecured` modifier, or you may choose to only use the `hint` modifier.

## How to Contribute

We welcome everyone to contribute to this project. If you find any problems or have any suggestions for improvements, please submit an issue. If you want to improve the project directly, please submit a pull request.

## License

MIT

