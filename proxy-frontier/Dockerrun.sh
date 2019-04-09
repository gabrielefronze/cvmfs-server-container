docker run --rm --name osg-frontier-squid \
-v `dirname "$0"`/squid.conf:/etc/squid/squid.conf \
-v /scratch/squid:/var/cache/squid \
-p 3128:3128 slateci/osg-frontier-squid
