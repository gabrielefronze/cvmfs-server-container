docker build -t slidspitfire/cvmfs-client-latest:latest .

docker run -t \
--name cvmfs-client \
--hostname cvmfs-client \
--privileged \
--volume /sys/fs/cgroup:/sys/fs/cgroup \
slidspitfire/cvmfs-client-latest:latest