FROM alexht/kaldi:pybind

COPY --from=pychain /workspace/pychain/openfst_binding /opt/pychain/openfst_binding
COPY --from=pychain /workspace/pychain/pytorch_binding /opt/pychain/pytorch_binding
COPY --from=pychain /workspace/pychain/pychain /opt/pychain/pychain
COPY --from=pychain /workspace/pychain/openfst/lib /opt/pychain/openfst/lib

ENV CUDA_HOME=/usr/local/cuda
ENV LD_LIBRARY_PATH=/opt/pychain/openfst/lib:/usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV PYTHONPATH=/opt/pychain
RUN cd /opt/pychain && \
	cd openfst_binding && python3 setup.py install && \
	cd ../pytorch_binding && python3 setup.py install
