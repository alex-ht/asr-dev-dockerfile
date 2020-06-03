FROM pytorch/pytorch:1.5-cuda10.1-cudnn7-devel

RUN sed -i "s:archive.:tw.archive.:g" /etc/apt/sources.list && apt-get update

# Install Kaldi
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    flac build-essential git subversion automake autoconf \
    unzip sox gfortran libtool python2.7 wget cmake
RUN ln -sf /bin/bash /bin/sh

RUN conda install -y pybind11 mkl-include h5py
RUN git clone --depth 1 --branch pybind11 https://github.com/kaldi-asr/kaldi.git /opt/kaldi && \
    cd /opt/kaldi/tools && \
    make -j $(nproc) && \
    cd /opt/kaldi/src && \
    ./configure --shared --use-cuda --mkl-root=/opt/conda --mkl-libdir=/opt/conda/lib && \
    make depend -j $(nproc) && \
    make -j $(nproc) && \
    cd /opt/kaldi/src/pybind && \
    make

WORKDIR /opt/kaldi
