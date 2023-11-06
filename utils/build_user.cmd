docker login
cd .\kaiaai-ros
docker image rm kaiaai/kaiaai-ros:humble
docker build --no-cache -t kaiaai/kaiaai-ros:humble --build-arg distro_tag=humble .
wt --window 0 -d . powershell "docker push kaiaai/kaiaai-ros:humble"
docker image rm kaiaai/kaiaai-ros:iron
docker build --no-cache -t kaiaai/kaiaai-ros:iron --build-arg distro_tag=iron .
wt --window 0 -d . powershell "docker push kaiaai/kaiaai-ros:iron"
