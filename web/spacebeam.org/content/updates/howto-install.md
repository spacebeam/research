title:  How To Install TorchCraft and Set Up a Programming Environment on Linux
date: 2020-07-09
description: TorchCraft is a BWAPI module that sends StarCraft data out over a ZMQ connection. This lets you parse game data and interact with BWAPI. 

{% img [class name(s)] /images/python.jpg %}

Python is an interpreted, high-level, general-purpose programming language with strengths in automation, data analysis and machine learning.

This tutorial will walk you through installing Python 3 and setting up a programming environment on Debian 10.

## Step 1 - Update and Upgrade

Logged into your system as root, first update and upgrade to ensure your shipped version of Python 3 is up-to-date.

```
# apt update
# apt upgrade
```

Confirm upgrade when prompted to do so.


## Step 2 - Check Version of Python

Check your version of Python 3 installed by typing:

```
# python3 --version
```

You'll receive output similar to the following.

```
Python 3.7.3
```

## Step 3 - Install pip

To manage software packages for Python, install `pip`, the standard package installer for Python. You can use pip to install things from the official package index and other indexes. 

```
# apt install -y python3-pip
```

Python packages can be installed by typing:

```
$ pip3 install schematics 
```

Here, schematics can refer to any Python package or library, such as tornado for backend development or NumPy for scientific computing. 

## Step 4 - Install Additional Tools
There are a few more packages and development tools to install to ensure that we have a robust set-up for our StarCraft: Brood War bots programming environment:

```
# apt install -y 
```


## Use WINE

## Running TorchCraft

`$ python python/example.py -t $server_ip`

