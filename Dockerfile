FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Chen Yuelong <yuelong.chen.btr@gmail.com>


ARG hisat2_version=2.1.0
ARG samtools_version=1.9


# install dependencies first
RUN apt-get update  && apt-get install -y \
    build-essential \
    gcc-multilib \
    zlib1g-dev \
    curl \
    wget \
    cmake \
    python \
    python-pip \
    python-dev \
    python2.7-dev \
    python-numpy \
    python-matplotlib \
    hdf5-tools \
    libhdf5-dev \
    hdf5-helpers \
    libhdf5-serial-dev \
    libssh2-1-dev \
    libcurl4-openssl-dev \
    icu-devtools \
    libssl-dev \
    libxml2-dev \
    r-bioc-biobase \
    git \
    apt-utils \
    pigz



# Install hisat2
WORKDIR /tmp/
RUN wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-${hisat2_version}-Linux_x86_64.zip && \
    unzip hisat2-${hisat2_version}-Linux_x86_64.zip && \
    cp -p hisat2-${hisat2_version}/hisat2 hisat2-${hisat2_version}/hisat* /usr/bin && \
    cd /tmp/ && \
    wget -c https://github.com/samtools/samtools/releases/download/$samtools_version/samtools-$samtools_version.tar.bz2 && \
    tar -jxvf samtools-$samtools_version.tar.bz2 && \
    cd samtools-$samtools_version && \
    ./configure && make && make install


RUN rm -rf /tmp/* && apt-get clean && apt-get remove --yes --purge build-essential \
    gcc-multilib apt-utils zlib1g-dev vim wget git

# Set default working path
CMD bash