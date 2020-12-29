FROM continuumio/miniconda
RUN conda create -n cling; \
        conda activate cling; \
        conda install xeus-cling -c conda-forge
RUN conda install jupyter
RUN jupyter kernelspec install PREFIX/share/jupyter/xcpp11 --sys-prefix \
    jupyter kernelspec install PREFIX/share/jupyter/xcpp14 --sys-prefix \
    jupyter kernelspec install PREFIX/share/jupyter/xcpp17 --sys-prefix
