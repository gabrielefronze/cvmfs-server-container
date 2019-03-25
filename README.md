# CVMFS layer for Virgo
This folder contains a working containerized installation of CVMFS aimed at providing a software distribution layer for the Virgo collaboration.

This work is based on several previous efforts, even if running the CVMFS server (stratum0 and stratum1) in a container was found to be poorly documented.

The setup is well described by the `docker-compose.yml` file, and includes a stratum-0 container (meant to be the place to push new data), a stratum-1 container (a replica, meant to be installed in satellite data centers) and a client container.

Every layer of the setup can be "hidden" behind a squid proxy with ease, granting HA and load balancing capabilities.

## Common settings
The procedure described below spawns three containers whose environment will be set up using the `cvmfs-variables.env` environment file. Each container is provided of an init script placed in `/etc/cvmfs-init-scripts` that sets up the local CVMFS server/client according to the settings propagated via the `cvmfs-variables.env` file.

## cvmfs_server_container helper
A helper bash function named `cvmfs_server_container` eases the usage of the docker containers needed to deploy the CVMFS infrastructure.
The function is implemented in the `cvmfs_server_container_helper.sh` script that has to be sourced in order to add the helper function to the `sh` environment, via:

```
    source /path/to/cvmfs_server_container_helper.sh
```

It is possible to add this command to the `.*rc` file to have the helper available inside any terminal session.

The helper function works mainly as a forwarder of CVMFS commands to the `cvmfs_server` function inside the container (something similar to `ssh root@container cvmfs_server $@)`.
The aim of such behavior is to be able to operate on the CVMFS repositories from the Docker host, even if the CVMFS server is ran inside a container.

Running the CVMFS servers inside containers is affected by the fact that containers are ephemeral by definition.
For this reason the recovery of existing repositories after a reboot, on a physical machine, is as easy as calling `cvmfs_server mount -a`, while on a container the thing is a bit trickier.
The picture gets even more complex in case the recovery has to be performed on a `prune`d container, that corresponds to a format of the OS disk or the replacement of a physical CFMS server.

The `cvmfs_server_container` shadows the standard `cvmfs_server` `mount` command, replacing it with a much stronger wrapper, able to recover from container prunes as well as undesired removal of CVMFS configuration files and entries.
The `cvmfs_server_container mount` command guarantees the resilience needed to a CVMFS deployment in the form of containers.

For further information on what commands and options are available, please refer to the `cvmfs_server_container help` menu which presents the standard `cvmfs_server` commands as well.

## Running the containers
Once `cvmfs_server_container` is available in the environment, the containers are ready to be built.
Two environment variables are needed for the automatic process to begin and are exported at the time of sourcing `cvmfs_server_container_helper.sh`.
These are:

* CVMFS_SERVER_LOCAL_GIT_REPO : where to clone, store and update the git repository containing the source and configuration files
* DEFAULT_HOST_CVMFS_ROOT_DIR : the default host path in which the repositories data will be stored. This parameter is used by some commands if another path is not specified.

The second variable is the most important one, since the reliability of the physical storage hardware on which such path resides conditions the reliability of the whole setup.

The first step is to ask the helper function to retrieve the GitHub repository for you via `cvmfs_server_container get`. This command will clone the remote repo if not found, or will do a pull for you if the repository is found.

The second step is to build the needed container image via `cvmfs_server_container build [0/1]`, where the option 0 (1) requires the command to build the stratum-0 (stratum-1) image.

Once the container has been built the `cvmfs_server_container run [0/1]` will run it for you.

From now on the procedures are coherent with the `cvmfs_server` standard ones, hence `mkfs` creates a new repo, `trensaction` enables modifications, `publish` dues the equivalent to `git push` etc.
As an addition the `mkfs-list` option is provided to instantiate several repositories at once with just the `-o root` option.

## Recovering killed/pruned/renewed stratum-0 container on existing data
As long as the data stored in the host's CVMFS root directory is not loss, the recovery can be accomplished by running the stratum-0 container via `cvmfs_server_container run 0` and then performing `cvmfs_server_container mount -a`. This command recovers and remounts all the repositories found in the host's CVMFS root directory.

## Networking requirements
In a multi-host setup the stratum-0 instance and the stratum-1 instances require the hosting machines to have a mutually reachable IP address on which TCP port 8000 is opened.

This means that if the machines are inside a LAN it should be enough to make their IP address static (or covered by a DDNS), while if the interconnection happens via WAN a public IP address should be foreseen.

## Technical recommendations
The block device the stratum-0 `/cvmfs` directory should physically reside has to be enabled with redundancy and fault resilience.
At least a RAID1 volume is highly recommended.

In order to better protect the whole setup against (hardware) failures it is recommended to place the physical volume on a device which is external to the stratum-0 host and mounted on the stratum-0 host in order to be passed to the stratum-0 container itself.

While the stratum-0 storage requires some fault tolerance and recovery capabilities the stratum-1 one is less critical, since in the event of a catastrophic failure the whole stratum-1 can be re-synchronized with the stratum-0 from scratch.

## Public keys distribution
The access rights both to the stratum-0 from the stratum-1, and from the clients to the stratum-1 itself, are granted via a public key exchange. The set of private+public keys is generated at the repository creation.

The previous setup works if and only if the public keys generated at the creation of the repository on the stratum-0 get distributed towards the stratum-1 and client containers.

After the execution of the stratum-0 init script, the public keys will be found at the path `/etc/cvmfs/keys/<repo_name>.pub`.
This file has to be copied to the stratum-1 and client (in the same path, according to the `cvmfs-variables.env` file) in order to allow access to the stratum-0 repository.

The `propagate-keys.sh` script is able to handle such task in the **single host** setup.
To propagate the same procedure in a multi-host setup, homologous commands have to be executed on different machines.

## How to handle crashes, container kills and prunes

### **Stratum0 procedures**
Some scripts are already installed in the `/etc/cvmfs-scripts` folder to tackle bizarre CVMFS behaviors in case of crashes and sudden shutdowns.

In case of `docker container kill`, that is equivalent to a reboot of a physical machine, it is enough to execute the `/etc/cvmfs-scripts/restore-kill-start.sh` script to get back to working order.

In case of `docker container kill &&  docker container prune`, that is equivalent to a replacement of the OS (aka fresh install), it is enough to execute the `/etc/cvmfs-scripts/restore-prune-start.sh` script to get back to working order without loosing any data.

### **Stratum1 procedures**
To be done...