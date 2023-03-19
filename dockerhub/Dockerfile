# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG OWNER=jupyter
ARG BASE_CONTAINER=$OWNER/base-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Install all OS dependencies for fully functional notebook server
# added curl and gnupg for analytics
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    # Common useful utilities
    git \
    curl \
    gnupg\
    nano-tiny \
    tzdata \
    unzip \
    vim-tiny \
    # git-over-ssh
    openssh-client \
    # less is needed to run help in R
    # see: https://github.com/jupyter/docker-stacks/issues/1588
    less \
    # nbconvert dependencies
    # https://nbconvert.readthedocs.io/en/latest/install.html#installing-tex
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-plain-generic \
    # Enable clipboard on Linux host systems
    xclip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# analytics prereq
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

RUN sudo apt-get install --yes git-lfs

# Install kestrel-LANG
RUN pip install kestrel-lang

# Create alternative for nano -> nano-tiny
RUN update-alternatives --install /usr/bin/nano nano /bin/nano-tiny 10

# Switch back to jovyan to avoid accidental container runs as root
USER ${NB_UID}

# Install kestrel-JUPYTER
RUN pip install kestrel-jupyter

# setup Jupyter
RUN python -m kestrel_jupyter_kernel.setup

RUN mv "${HOME}/.local/share/jupyter/kernels/kestrel"* "${CONDA_DIR}/share/jupyter/kernels/" && \
    chmod -R go+rx "${CONDA_DIR}/share/jupyter" && \
    rm -rf "${HOME}/.local"

# Add R mimetype option to specify how the plot returns from R to the browser
COPY --chown=${NB_UID}:${NB_GID} Rprofile.site /opt/conda/lib/R/etc/

# Install kestrel-ANALYTICS
RUN git clone https://github.com/opencybersecurityalliance/data-bucket-kestrel.git

RUN mkdir -p analytic-tutorials && \
    mkdir -p huntbooks && \
    mkdir -p tutorial && \
    mkdir -p blackhat22

# for generic huntbooks like BH22
RUN cp -r data-bucket-kestrel/stix-bundles anaytic-tutorials

# for the tutorial
RUN cp data-bucket-kestrel/stix-bundles/lab101.json analytic-tutorials

RUN git clone https://github.com/opencybersecurityalliance/kestrel-analytics.git

RUN cp data-bucket-kestrel/GeoLite2/GeoLite2-City.mmdb kestrel-analytics/analytics/piniponmap

RUN rm -rf "${HOME}/data-bucket-kestrel"

# install kestrel-HUNTBOOK
RUN git clone https://github.com/opencybersecurityalliance/kestrel-huntbook.git

RUN mkdir -p ~/.config/kestrel && \
    mv kestrel-huntbook/config/stixshifter.yaml ~/.config/kestrel/ && \
    ln -s ~/.config/kestrel/stixshifter.yaml kestrel-huntbook/huntbooks/stixshifter.yaml && \
    ln -s ~/.config/kestrel/stixshifter.yaml kestrel-huntbook/tutorial/stixshifter.yaml && \
    ln -s ~/.config/kestrel/stixshifter.yaml kestrel-huntbook/blackhat22/stixshifter.yaml

RUN rmdir kestrel-huntbook/config

RUN cp kestrel-analytics/pythonanalytics_sample.yaml ~/.config/kestrel/pythonanalytics.yaml

#RUN jupyter trust */*.ipynb