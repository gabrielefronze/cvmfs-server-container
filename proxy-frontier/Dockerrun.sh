docker run --rm --name cvmfs-squid \
-v /scratch/squid:/var/cache/squid \
-p 3128:3128 slidspitfire/cvmfs-frontier-squid
