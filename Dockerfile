# syntax=docker/dockerfile:1

# SPDX-FileCopyrightText: Copyright (c) 2022-2023 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


############################################################
# Base image
############################################################

ARG BASE_IMAGE
ARG GPU_TYPE

FROM ${BASE_IMAGE} AS base

ARG DEBIAN_FRONTEND=noninteractive

# --------------------------------------------------------------------------
#
# Holohub run setup 
#

RUN mkdir -p /tmp/scripts
COPY run /tmp/scripts/
RUN mkdir -p /tmp/scripts/utilities
COPY utilities/holohub_autocomplete /tmp/scripts/utilities/
RUN chmod +x /tmp/scripts/run
RUN /tmp/scripts/run setup

# Enable autocomplete
RUN echo ". /etc/bash_completion.d/holohub_autocomplete" >> /etc/bash.bashrc

# - This variable is consumed by all dependencies below as an environment variable (CMake 3.22+)
# - We use ARG to only set it at docker build time, so it does not affect cmake builds
#   performed at docker run time in case users want to use a different BUILD_TYPE
ARG CMAKE_BUILD_TYPE=Release

# Qcap dependency
RUN apt update \
    && apt install --no-install-recommends -y \
        libgstreamer1.0-0 \
        libgstreamer-plugins-base1.0-0 \
        libgles2 \
        libopengl0

# For benchmarking
RUN apt update \
    && apt install --no-install-recommends -y \
    libcairo2-dev \
    libgirepository1.0-dev \
    gobject-introspection \
    libgtk-3-dev \
    libcanberra-gtk-module \
    graphviz
RUN if ! grep -q "VERSION_ID=\"22.04\"" /etc/os-release; then \
        pip install setuptools; \
    fi
COPY benchmarks/holoscan_flow_benchmarking/requirements.txt /tmp/benchmarking_requirements.txt
RUN pip install -r /tmp/benchmarking_requirements.txt

# For RTI Connext DDS
RUN apt update \
    && apt install --no-install-recommends -y \
        openjdk-21-jre
RUN echo 'export JREHOME=$(readlink /etc/alternatives/java | sed -e "s/\/bin\/java//")' >> /etc/bash.bashrc
