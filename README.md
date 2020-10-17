![](https://img.shields.io/badge/Microverse-blueviolet)

<h1 align="center">Lintertin</h1>

> This is a simple Ruby linter, used to improve code quality and readability. Its name is Lintertin, linter because it's a linter, and tin from the end of my name (Martin) 😉

You can test a single file, and also you can test all the files that exist in the root directory by using this linter.

## Good and Bad examples

### Trailing spaces

```Bad Example
class ForTest
  'def method   '
  end
end

```

```Good Example
class ForTest
  'def method'
  end
end

```

### Correct indentation

```Bad Example
class ForTest
def method
  end
end

```

```Good Example
class ForTest
  def method
  end
end

```

### Empty lines

```Bad Example
class ForTest

  def method
  end
end

```

```Good Example
class ForTest
  def method
  end
end

```

### Single empty line at the bottom of the file

```Bad Example
class ForTest
  def method
  end
end
```

```Good Example
class ForTest
  def method
  end
end

```

### Braces, brackets and parenthesis

Consider the following examples:

#### Parenthesis

```Bad Example
class ForTest
  def method(param
  end
end

```

```Good Example
class ForTest
  def method(param)
  end
end

```

#### Braces

```Bad Example
class ForTest
  def method(array)
    array.each { |n| puts n
  end
end

```

```Good Example
class ForTest
  def method(array)
    array.each { |n| puts n }
  end
end

```

#### Brackets

```Bad Example
class ForTest
  def method(array)
    puts array[3
  end
end

```

```Good Example
class ForTest
  def method(array)
    puts array[3]
  end
end

```

### Pipes |

#### Spaces before or after the pipe

```Bad Example
class ForTest
  def method(array)
    array.each do |elem |
    end
  end
end

```

```Good Example
class ForTest
  def method(array)
    array.each do |elem|
    end
  end
end

```

#### Missing pipe

```Bad Example
class ForTest
  def method(array)
    array.each do |elem
    end
  end
end

```

```Good Example
class ForTest
  def method(array)
    array.each do |elem|
    end
  end
end

```

**Warning:** If there's a space before or after the pipe, then it will not check for a missing one.

**Warning:** This linter doesn't work with the inline `if` and inline `unless`!! For instance:

```
return 'something' if I'm_true\n
```

```
return 'something' unless I'm_true
```

## Built With

- Ruby
- Rubocop: as a linter

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

You should have [Ruby](https://www.ruby-lang.org/en/documentation/installation/) installed on your machine.

### Setup

Open your terminal, type `git clone https://github.com/martinnajjar12/lintertin.git` and hit Enter to download this repository.

### Install

- At first, make sure that you have `bundler` installed on your machine. Again in your terminal type the command `bundler -v`. If a version showed up, skip the next step, if not please continue.
- Type the command `gem install bundler` and hit Enter to install bundler on your machine.
- Now you're ready to start! Type in your terminal `bundle install` to get the required dependencies to run this linter.

### Usage

This linter is used to maintain code quality and improve readability.

### Run tests

You can test the project with RSpec! Simply type `rspec` in your terminal to see the test results. Make sure to do this step after completing [the install section](#install)

## Author

👤 **Martin Najjar**

- GitHub: [Martin Najjar](https://github.com/martinnajjar12)
- Twitter: [Martin Najjar](https://twitter.com/martin_najjar)
- LinkedIn: [Martin Najjar](https://linkedin.com/in/martinnajjar12)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/martinnajjar12/lintertin/issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Built as a capstone project for Ruby section in [Microverse](https://www.microverse.org/)
- Inspired by the idea of [Rubocop](https://docs.rubocop.org/rubocop/index.html)

### 📝 License

This project is [MIT](https://github.com/martinnajjar12/lintertin/blob/development/LICENSE) licensed.
