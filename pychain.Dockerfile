FROM pytorch/pytorch:1.5-cuda10.1-cudnn7-devel as build_pychain
RUN apt-get update && apt-get install -y git wget
# RUN pip install kaldi_io
RUN git clone --depth=1 https://github.com/YiwenShaoStephen/pychain.git
RUN cd pychain && make openfst -j $(nproc)
ENV TORCH_CUDA_ARCH_LIST="3.7+PTX;5.0;6.0;6.1;7.0;7.5"
RUN cd pychain && make pychain
