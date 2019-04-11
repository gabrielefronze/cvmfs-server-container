docker run -t -d \
--name cvmfs-client \
--hostname cvmfs-client \
--privileged \
--volume /sys/fs/cgroup:/sys/fs/cgroup \
slidspitfire/cvmfs-client