FROM continuumio/miniconda
RUN conda install jupyter
RUN conda install jupyterlab

RUN apt-get update
RUN apt-get install -y \
  sudo \
  procps

ADD cmd.sh .

ENTRYPOINT ["bash", "-x", "cmd.sh"]
