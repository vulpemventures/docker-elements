# Docker liquid

Dockerfile of the public image [ghcr.io/vulpemventures/elements:latest](https://github.com/orgs/vulpemventures/packages/container/package/elements)

Pull the image:

```bash
$ docker pull ghcr.io/vulpemventures/elements:latest
```

Run the image:

```bash
$ docker run -v path/to/liquid.conf:/home/elements/.elements -d ghcr.io/vulpemventures/elements:latest
```