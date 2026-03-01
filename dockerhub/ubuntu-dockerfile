# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
# for reference on tutorials and data see https://github.com/opencybersecurityalliance/kestrel-huntbook/tree/main/.binder
# This is the WG copy.  kestrel-lang contains master - source of truth
ARG OWNER=jupyter
ARG BASE_CONTAINER=$OWNER/base-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# ROOT ACTIVITIES
USER root

# Install all OS dependencies for fully functional notebook server
RUN apt-get update && apt-get install --yes --no-install-recommends \
        # Common useful utilities
        curl \
        dnsutils \
        git \
        gnupg\
        less \
        nano-tiny \
        openssh-client \
        texlive-fonts-recommended \
        texlive-plain-generic \
        texlive-xetex \
        tzdata \
        unzip \
        vim-tiny \
        whois \
        xclip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# install the python prerequisites
# 1. from requirements.txt for jupyter hub
# https://github.com/opencybersecurityalliance/kestrel-huntbook/blob/main/.binder/requirements.txt
# analytics::dataexfiltration analytics::log4shell analytics::piniponmap analytics::sklearn-cluster analytics::attribute-plot analytics::suspiciousscoring
RUN pip install \
        business-rules \
        flask \
        flask-cors \
        folium \
        geoip2 \
        gower \
        kestrel-jupyter \
        matplotlib \
        nbgitpuller \
        scikit-learn \
        tabulate \
        urllib3

# 2. from apt.txt
# analytics prereq for cloning data-bucket-kestrel
# mapped to apt.txt https://github.com/opencybersecurityalliance/kestrel-huntbook/blob/main/.binder/apt.txt
# debian required
# from postbuild
# https://github.com/opencybersecurityalliance/kestrel-huntbook/blob/main/.binder/postBuild
################################
# 1. Setup Git LFS - to setup gitlab-lfs for this container it has to be grabbed from the site as git-lfs is not in the repo for the base
################################
# analytics prereq
ARG GIT_LFS_SETUP_SCRIPT_SHA=8c4d07257b8fb6d612b6085f68ad33c34567b00d0e4b29ed784b2a85380f727b
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh -o /tmp/script.deb.sh \
 && echo "${GIT_LFS_SETUP_SCRIPT_SHA}  /tmp/script.deb.sh" | sha256sum -c - \
 && sudo bash /tmp/script.deb.sh \
 && rm /tmp/script.deb.sh \
 && sudo apt-get install --yes git-lfs

RUN mkdir -p /opt/kaas \
 && chown ${NB_UID}:${NB_UID} /opt/kaas

# COPY kaas-logo-san-seriff.png /opt/kaas/kaas-logo-san-seriff.png

# USER ACTIVITIES
# Switch back to /home/jovyan to avoid accidental container runs as root
USER ${NB_UID}

RUN git lfs install

################################
# 2. Setup Kestrel Kernel
################################
RUN kestrel_jupyter_setup
################################
RUN mv "/home/jovyan/.local/share/jupyter/kernels/kestrel"* "${CONDA_DIR}/share/jupyter/kernels/" \
 && chmod -R go+rx "${CONDA_DIR}/share/jupyter" \
 && rm -rf "/home/jovyan/.local"

# Add R mimetype option to specify how the plot returns from R to the browser
RUN curl https://raw.githubusercontent.com/kpeeples/kestrel-as-a-service/main/dockerhub/Rprofile.site -o /home/jovyan/Rprofile.site \
 && chown ${NB_UID}:${NB_GID} /home/jovyan/Rprofile.site \
 && mkdir -p /opt/conda/lib/R/etc \
 && mv Rprofile.site /opt/conda/lib/R/etc/Rprofile.site

# from postbuild
# https://github.com/opencybersecurityalliance/kestrel-huntbook/blob/main/.binder/postBuild
################################
# 3. Obtain Data -- This copies all data and notebooks required
# Place data in /opt/kaas and then move to home for
# KaaS (Kubernetes/Jupyterhub/Containers)
################################
RUN git clone https://github.com/opencybersecurityalliance/data-bucket-kestrel.git /opt/kaas/data-bucket-kestrel \
 && git clone https://github.com/opencybersecurityalliance/kestrel-huntbook.git /opt/kaas/kestrel-huntbook \
 && git clone https://github.com/opencybersecurityalliance/kestrel-analytics.git /opt/kaas/kestrel-analytics \
 && ln -s /opt/kaas/data-bucket-kestrel /home/jovyan/data-bucket-kestrel \
 && ln -s /opt/kaas/kestrel-huntbook /home/jovyan/kestrel-huntbook \
 && ln -s /opt/kaas/kestrel-analytics /home/jovyan/kestrel-analytics \
 && cp /opt/kaas/data-bucket-kestrel/stix-bundles/lab101.json /tmp \
 && cp /opt/kaas/data-bucket-kestrel/GeoLite2/GeoLite2-City.mmdb /opt/kaas/kestrel-analytics/analytics/piniponmap/GeoLite2-City.mmdb

# from postbuild
# https://github.com/opencybersecurityalliance/kestrel-huntbook/blob/main/.binder/postBuild
################################
# 4. Setup Configurations
################################
# The config is for the Black Hat Tutorial
RUN mkdir -p /home/jovyan/.config/kestrel \
 && mv /opt/kaas/kestrel-huntbook/config/stixshifter.yaml /home/jovyan/.config/kestrel/
# this is for the getting started tutorial 5
RUN cp /opt/kaas/kestrel-analytics/pythonanalytics_sample.yaml /home/jovyan/.config/kestrel/pythonanalytics.yaml
# this enables trusted ipynb files for jupyter
RUN jupyter trust /home/jovyan/kestrel-huntbook/tutorial/*.ipynb \
 && jupyter trust /home/jovyan/kestrel-huntbook/huntbooks/*.ipynb \
 && jupyter trust /home/jovyan/kestrel-huntbook/blackhat22/*.ipynb

################################
#
#
# Test cases for validation of container:
#   1. run for a standalone container
#   2. run within Kaas Minikube
#   3. run within KaaS Full Cluster
#
# KaaS Metrics
#   1. Silo-d hunter without kestrel - minimal sharing
#   2. standalone kestrel hunter - some collaboration
#   3. KaaS kestrel hunter - full collaboration features
#
# Tutorial Order from easy to hardest
#   kestrel-huntbook/tutorial
#   kestrel-huntbook/blackhat22
#   kestrel-huntbook/huntbooks
#
# ADD: slack hunter integration
