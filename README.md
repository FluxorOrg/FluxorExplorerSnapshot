# FluxorExplorerSnapshot

A struct to be used by [FluxorExplorerInterceptor](https://github.com/FluxorOrg/FluxorExplorerInterceptor) to send the dispatched `Action`, the old state and the new state, to [FluxorExplorer](https://github.com/FluxorOrg/FluxorExplorer).

[![Swift version](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFluxorOrg%2FFluxorExplorerSnapshot%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/FluxorOrg/FluxorExplorerSnapshot)
[![Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFluxorOrg%2FFluxorExplorerSnapshot%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/FluxorOrg/FluxorExplorerSnapshot)

![Test](https://github.com/FluxorOrg/FluxorExplorerSnapshot/workflows/CI/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/41718cad43bbf98de4b4/maintainability)](https://codeclimate.com/github/FluxorOrg/FluxorExplorerSnapshot/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/54bb7b6c7d93f100fc60/test_coverage)](https://codeclimate.com/github/FluxorOrg/FluxorExplorerSnapshot/test_coverage)
![Twitter](https://img.shields.io/badge/twitter-@mortengregersen-blue.svg?style=flat)

## 🤔 When should I use FluxorExplorerSnapshot?
You should never have to use FluxorExplorerSnapshot directly. [FluxorExplorerInterceptor](https://github.com/FluxorOrg/FluxorExplorerInterceptor) uses it to encode the data intercepted from the `Store` to send it to [FluxorExplorer](https://github.com/FluxorOrg/FluxorExplorer) which would decode it and show it.
