# neuroglancer-docker
The project is a docker image for the neuroglancer project so that neuroglancer python interface can be more easily deployed in a production environment. A demo video with over 1GB of PETCT imaging data can be seen [here](https://www.youtube.com/watch?v=BtCe6VCz7Bw&feature=youtu.be)

# Getting Start

## Binder

You can use a prebuilt image on binder inside Jupyter Notebook or Jupyter Lab
 - [![Binder](https://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/4QuantOSS/neuroglancer-docker/master)
- [![Binder]( https://img.shields.io/badge/launch-jupyterlab-red.svg)](https://mybinder.org/v2/gh/4QuantOSS/neuroglancer-docker/master?urlpath=lab)

### Notebooks

 - [![Binder](https://img.shields.io/badge/launch-example%20notebook-green.svg)](https://mybinder.org/v2/gh/4QuantOSS/neuroglancer-docker/master?filepath=notebooks%2FSimpleNumpyDemo.ipynb)

 - [![Binder](https://img.shields.io/badge/launch-NPZ%20notebook-green.svg)](https://mybinder.org/v2/gh/4QuantOSS/neuroglancer-docker/master?filepath=notebooks%2FNPZLoadingExample.ipynb)

  - [![Binder](https://img.shields.io/badge/launch-Skeleton%20notebook-green.svg)](https://mybinder.org/v2/gh/4QuantOSS/neuroglancer-docker/master?filepath=notebooks%2FSkeletonDemo.ipynb)

## Docker

### Building the Image
In the main directory of the project you can run
```
docker build -t 4quant/neuroglancer .
```
To build the docker image with the tag ```4quant/neuroglancer```


### Running the image
To just run the image in the default mode (notebook), you simple type
```
docker run -i -p 8989:8989 -p 8888:8888 -t 4quant/neuroglancer
```

#### Running with the notebooks saved locally (instead of lost inside docker)
```
docker run -i -p 8989:8989 -p 8888:8888 -v $PWD/notebooks:/home/neuroglancer_user/local_notebooks -t 4quant/neuroglancer
```

#### Running with local notebooks and data

In this case the data is located in the current directory in a folder called _data_ but this can be changed to anything

```
docker run -i -p 8989:8989 -p 8888:8888 -v $PWD/notebooks:/home/neuroglancer_user/local_notebooks -v $PWD/data/:/home/neuroglancer_user/local_data -t 4quant/neuroglancer
```

### Note

If you have not built the image locally it will be downloaded from [docker hub](https://hub.docker.com/r/4quant/neuroglancer/).

You can then navigate to http://localhost:8888 and you will be taken to the notebook interface where you can run a demo by simply running the blocks in the SimpleNumpyDemo notebook (inside the notebooks directory)

## Run the notebook interface

```
docker run -i -p 8989:8989 -p 8888:8888 -t 4quant/neuroglancer jupyter notebook --ip='0.0.0.0'
```

## Run just the python demo

```
docker run -i -p 8989:8989 -t 4quant/neuroglancer python -i docker_demo.py
```
