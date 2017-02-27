# neuroglancer-docker
The project is a docker image for the neuroglancer project so that neuroglancer python interface can be more easily deployed in a production environment. 

# Building the Image
In the main directory of the project you can run 
```
docker build -t 4quant/neuroglancer .
```
To build the docker image with the tag ```4quant/neuroglancer```


# Running the image
To just run the image in the default mode (notebook), you simple type 
```
docker run -i -p 8989:8989 -p 8888:8888 -t 4quant/neuroglancer
```

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

