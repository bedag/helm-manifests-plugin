# Helm Manifests Plugin

The Plugin is used to currently render values for the [Helm Manifests Chart](https://github.com/bedag/helm-charts/tree/master/charts/manifests). It's a simple bash wrapper but does not require you to download the entire github repository. More features might be added in the future.

# Install

You can directly install the plugin by referencing this repository:

```
helm plugin install https://github.com/bedag/helm-manifests-plugin.git
```

# Uninstall

To remove the plugin, use the following command:

```
helm plugin uninstall manifests
```

# Usage

Learn which arguments are available:

```
helm manifests -h
```

# Examples

NOTE: You can only get the values for one manifest **or** preset per command.

Just running the plugin without any parameters return common values/extra values which don't apply to a single resource.

```
helm manifests
```

Render Values for a `Statefulset` Manifest:

```
helm manifests -m "statefulset"
```

With Minimal Output:

```
helm manifests -m "statefulset" -M
```

Get all values for a service under the parentkey `headless`:

```
helm manifests -m "service" -k "headless"
```

Get the `jmxExporter` preset under the custom path `jmxExporter.*`:

```
helm manifests -p "jmxexporter" -P "jmxExporter"
```

# Contributing

We'd love to have you contribute! Please refer to our [contribution guidelines](CONTRIBUTING.md) for details.

**By making a contribution to this project, you agree to and comply with the
[Developer's Certificate of Origin](./DCO).**

# License

[Apache 2.0 License](./LICENSE).
