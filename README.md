# Docker liquid

Dockerfile of the public image [vulpemventures/liquid:latest](https://hub.docker.com/r/vulpemventures/liquid)

Pull the image:

```bash
$ docker pull vulpemventures/liquid
```

Run the image:

```bash
$ docker run -p 18884:18884 -v path/to/liquid.conf:/config -d vulpemventures/liquid
```