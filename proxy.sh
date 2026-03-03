#!/bin/bash
export https_proxy="http://192.168.64.2:7890"
export http_proxy=${https_proxy}
export no_proxy="172.16.16.0/24"
eval $@
