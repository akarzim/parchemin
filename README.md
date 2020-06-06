<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/akarzim/parchemin">
    <img src="images/logo.svg" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Parchemin</h3>

  <p align="center">
    Colours the contents of a file according to its age.
    <br />
    <a href="https://github.com/akarzim/parchemin"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/akarzim/parchemin/issues">Report Bug</a>
    ·
    <a href="https://github.com/akarzim/parchemin/issues">Request Feature</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Installation](#installation)
* [Usage](#usage)
* [Roadmap](#roadmap)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)

## About The Project

**DISCLAIMER**: This is a toy project to play with the [dry-cli][dry-cli] Ruby gem.

[![Parchemin Screen Shot][product-screenshot]][product-screenshot]

### Built With

* [dry-cli][dry-cli]
* [colorize][colorize]

## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

* [git](https://git-scm.com/downloads)

### Installation

1. Clone the repo

```sh
git clone https://github.com/akarzim/parchemin.git
```

## Usage

In a terminal, step inside the Parchemin directory and run:

```sh
❯ ./parchemin --help
Commands:
  parchemin color [SUBCOMMAND]
  parchemin read FILE                         # Read the given file
  parchemin version                           # Print version
```

The main command is `read` which takes some optional arguments:

```sh
❯ ./parchemin read --help
Command:
  parchemin read

Usage:
  parchemin read FILE

Description:
  Read the given file

Arguments:
  FILE                	# REQUIRED File to read

Options:
  --strategy=VALUE, -s VALUE      	# Colorization strategy: (scratch/strata/random/none), default: :random
  --help, -h                      	# Print this help

Examples:
  parchemin read path/to/file # Run Parchemin from file

```

For now, 4 strategies are available:

- **none**: just render the git blame output on FILE
- **random**: pick a random sepia color for each line of FILE
- **strata**: set each line color according to its age. The oldest, the darkest
- **scratch**: same as _strata_ but with slight variations on each character.

## Roadmap

See the [open issues](https://github.com/akarzim/parchemin/issues) for a list of proposed features (and known issues).

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

François Vantomme - [@akarzim](https://mastodon.host/@akarzim)

Project Link: <https://github.com/akarzim/parchemin>

## Acknowledgements

* [Gruvbox][gruvbox] colorscheme
* [Larry Sanger][globewalldesk] for [this issue on Colorize][colorize-issue]
* [Othneil Drew][othneildrew] for [this readme template][readme-template]

<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/akarzim/parchemin.svg?style=flat-square
[contributors-url]: https://github.com/akarzim/parchemin/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/akarzim/parchemin.svg?style=flat-square
[forks-url]: https://github.com/akarzim/parchemin/network/members
[stars-shield]: https://img.shields.io/github/stars/akarzim/parchemin.svg?style=flat-square
[stars-url]: https://github.com/akarzim/parchemin/stargazers
[issues-shield]: https://img.shields.io/github/issues/akarzim/parchemin.svg?style=flat-square
[issues-url]: https://github.com/akarzim/parchemin/issues
[license-shield]: https://img.shields.io/github/license/akarzim/parchemin.svg?style=flat-square
[license-url]: https://github.com/akarzim/parchemin/blob/master/LICENSE.txt
[product-screenshot]: images/screenshot.png
[dry-cli]: https://dry-rb.org/gems/dry-cli/0.6/
[colorize]: https://github.com/fazibear/colorize
[gruvbox]: https://github.com/morhetz/gruvbox
[globewalldesk]: https://gitlab.com/globewalldesk
[colorize-issue]: https://github.com/fazibear/colorize/issues/66
[othneildrew]: https://github.com/othneildrew
[readme-template]: https://github.com/othneildrew/Best-README-Template
