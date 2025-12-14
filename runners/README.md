# Launch multiple self-hosted runners

More on authentification:

<https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry>

login:

echo "$TOKEN" | docker login ghcr.io -u vabalops --password-stdin

build image:

`podman image build -t ghcr.io/vabalops/gha-lab/runner:latest .`

push image:

`podman image push ghcr.io/vabalops/gha-lab/runner:latest`

`podman image tag ghcr.io/vabalops/gha-lab/runner:latest ghcr.io/vabalops/gha-lab/runner:v0.1.0`

`podman image push ghcr.io/vabalops/gha-lab/runner:v0.1.0`

start multiple containers:

`podman compose --file compose.yaml up`

stop containers:

`podman compose down runner`
