# FluxorExplorerSnapshot

A struct to be used by [FluxorExplorerStoreInterceptor](https://github.com/MortenGregersen/FluxorExplorerStoreInterceptor) to send the dispatched `Action`, the old state and the new state, to [FluxorExplorer](https://github.com/MortenGregersen/FluxorExplorer).

![Platforms](https://img.shields.io/badge/platforms-Mac+iOS-brightgreen.svg?style=flat)
![Swift version](https://img.shields.io/badge/Swift-5.1-brightgreen.svg)
![Swift PM](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg?style=flat)
![Twitter](https://img.shields.io/badge/twitter-@mortengregersen-blue.svg?style=flat)

![Test](https://github.com/MortenGregersen/FluxorExplorerSnapshot/workflows/CI/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/41718cad43bbf98de4b4/maintainability)](https://codeclimate.com/github/MortenGregersen/FluxorExplorerSnapshot/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/41718cad43bbf98de4b4/test_coverage)](https://codeclimate.com/github/MortenGregersen/FluxorExplorerSnapshot/test_coverage)

## When should I use FluxorExplorerSnapshot
You should never have to use FluxorExplorerSnapshot directly. [FluxorExplorerStoreInterceptor](https://github.com/MortenGregersen/FluxorExplorerStoreInterceptor) uses it to encode the data intercepted from the `Store` to send it to [FluxorExplorer](https://github.com/MortenGregersen/FluxorExplorer) which would decode it and show it.