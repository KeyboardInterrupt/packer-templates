# Packer Templates

Packer templates that simplify the creation of fully patched, minimally-sized and Ansible ready Vagrant boxes.

## Prerequisites

To build the boxes you need the following prerequisites.

- Packer
- Virtualbox (if you want to build boxes for the virtualbox provider)
- libvirt + qemu (if you want to build Boxes for the libvirt Provider)

## How to build the box

To build the Boxes you need to run packer build, on the corresponding Template (Json Files)like this:

### Example for `alpine-3.7-x86_64.json`

``` bash
packer build -parallel=false alpine-3.7-x86_64.json
``` 

the option `-parallel=false` is needed because you cannot run the qemu/libvirt and virtualbox provider in parallel.

If you only want to build either the `qemu` or `virtualbox` box you need to add the option `-only <PROVIDER>` to the packer build command like this:

``` bash
packer build -only=qemu alpine-3.7-x86_64.json
```

or 

``` bash
packer build -only=virtualbox-iso alpine-3.7-x86_64.json
```

### Overwriting defaults

If you i.e. want to build boxes with more RAM, without compression or bigger Disk size you can pass a Variable file to the packer build command by giving it the option `-var-file=<PATH>`.

Example Variable files can be found in `./vars/`

``` bash
packer build -var-file=./vars/development.json
```

Alternatively you can set a Variable directly on the commandline by passing the `-var 'key=value'` option.

```bash
packer build -var compression_level=6 -var disk_size=10000 alpine-3.7-x86_64.json
```

## Usage in Vagrant

You can either use the prebuilt Boxes over here:
[KeboardInterrupt's Boxes on Vagrant Cloud](https://app.vagrantup.com/kbi/), upload them to your own account on Vagrant Cloud or use the boxes you built locally.

``` bash
vagrant box add ./alpine.3.7.0-x86_64-virtualbox.box
```