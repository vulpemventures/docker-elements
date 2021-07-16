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

## Release

To tag a new image with a new version:

1) Create a new folder with `VERSION` as directory name
2) Modify the GH Action in `.github/workflows/docker-publish.yml` changing the ARG `VERSION` with new created folder
3) Push in master
