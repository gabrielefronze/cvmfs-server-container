docker build -t slidspitfire/cvmfs-client-latest:latest .

docker run -t \
-p 80:80 -p 8000:8000 \
--name cvmfs-client \
--hostname cvmfs-client \
--privileged \
--volume /sys/fs/cgroup:/sys/fs/cgroup \
slidspitfire/cvmfs-client-latest:latest