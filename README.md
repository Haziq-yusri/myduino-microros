# Microros Docker images

[Kaia.ai](https://kaiaai) is a platform for 3D-printable pet robots. Please sign up for an early launch invite [here](https://remake.ai).

Questions? Please visit the [Support Forum](https://github.com/makerspet/support/discussions/)!

## Download Latest Pre-Built Image
- Docker Hub [image](https://hub.docker.com/r/kaiaai/kaiaai)
  - `docker pull kaiaai/kaiaai:humble`
  - `docker pull kaiaai/kaiaai:iron`

## Docker setup video (outdated)
<a href="http://www.youtube.com/watch?feature=player_embedded&v=XOc5kCE3MC0" target="_blank">
 <img src="http://img.youtube.com/vi/XOc5kCE3MC0/maxresdefault.jpg" alt="Robot Arduino firmware, ROS2/Docker PC setup instructions video" width="720" height="405" border="10" />
</a>

## Install Docker
- If you are using a Windows PC, install [Windows WSL 2](https://learn.microsoft.com/en-us/windows/wsl/install)
and [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/)
- When using a Linux PC, install [Docker Engine](https://docs.docker.com/engine/install/ubuntu/) or
[Docker Desktop](https://docs.docker.com/desktop/install/linux-install/) (with GUI).
On Ubuntu 22.04 you can run
```
git clone --depth 1 https://github.com/kaiaai/docker
cd docker
. utils/install_docker_on_ubuntu.sh
```

## Optional, log in to Docker Hub
```
sudo docker login -u your_docker_hub_username
```

## Build all images - Linux
- install [Docker for Linux](https://docs.docker.com/engine/install/ubuntu/)
- clone the Kaia.ai Docker repo and run the command below
```
git clone https://github.com/kaiaai/docker
cd docker
. utils/build_all.sh
```

## Build all images - Windows
- install [Docker for Windows](https://docs.docker.com/desktop/install/windows-install/)
- clone the Kaia.ai Docker repo and run the command below
```
git clone https://github.com/kaiaai/docker
cd docker
.\utils\build_all.cmd
```
