FROM debian:jessie
MAINTAINER kmader <kmader@4quant.com>
ENV DEBIAN_FRONTEND noninteractive
ENV CONDA_DIR /opt/conda

# Core installs
RUN apt-get update && \
    apt-get install -y git vim wget build-essential python-dev ca-certificates bzip2 libsm6 && \
    apt-get clean

# Install miniconda 2.7
RUN echo 'export PATH=$CONDA_DIR/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86_64.sh && \
    /bin/bash /Miniconda2-4.3.11-Linux-x86_64.sh -b -p $CONDA_DIR && \
    rm Miniconda2-4.3.11-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda install --yes conda==4.2.9

# Create a user
RUN useradd -m -s /bin/bash neuroglancer_user
RUN chown -R neuroglancer_user:neuroglancer_user $CONDA_DIR

# Env vars
USER neuroglancer_user
ENV HOME /home/neuroglancer_user
ENV SHELL /bin/bash
ENV USER neuroglancer_user
ENV PATH $CONDA_DIR/bin:$PATH
WORKDIR $HOME

# setup the rest of the packages
RUN conda install --yes nose numpy pandas matplotlib scipy seaborn numba bokeh pillow ipython
# Install Jupyter notebook to allow for more interactive neuroglancing
RUN conda install --quiet --yes \
    'notebook=4.2*' \
    && conda clean -tipsy

# install neuroglancer from github
RUN git clone https://github.com/google/neuroglancer.git
WORKDIR neuroglancer/python
RUN ls ../../*
RUN python setup.py install

ADD docker_demo.py $HOME/docker_demo.py
ADD notebooks $HOME/notebooks
USER root
RUN chown -R neuroglancer_user:neuroglancer_user $HOME/notebooks
RUN chown -R neuroglancer_user:neuroglancer_user $HOME/docker_demo.py

# Open ports for the notebook and the server
EXPOSE 8888
EXPOSE 8989

# run the notebook as a user
USER neuroglancer_user
# CMD python -i docker_demo.py
WORKDIR $HOME/notebooks
CMD jupyter notebook --ip='0.0.0.0'