FROM debian:buster

LABEL maintainer="stevenbetancurt@hotmail.com"

WORKDIR /forecast

COPY ./models /forecast/models
COPY ./test /forecast/test

ENV MODELS_DIR=/forecast/models
ENV MODELS_TMP=/forecast/tmp
ENV MODELS_WORKDIR=/forecast/workdir
#ENV MODELS_ORYZA_MODEL=oryza_model
#ENV MODELS_ORYZA_DIR=${MODELS_DIR}/${MODELS_ORYZA_MODEL}
ENV MODELS_DSSAT_MODEL=dssat-csm
ENV MODELS_DSSAT_GITHUB=dssat-csm-os
ENV MODELS_DSSAT_GITHUB_URL=https://github.com/DSSAT/dssat-csm-os
ENV MODELS_DSSAT_DIR=${MODELS_DIR}/${MODELS_DSSAT_MODEL}
ENV MODELS_CPT_MODEL=CPT
ENV MODELS_CPT_VERSION=17.6.1
ENV MODELS_CPT_SOURCE=${MODELS_CPT_MODEL}.${MODELS_CPT_VERSION}.tar.gz
ENV MODELS_CPT_DIR=${MODELS_DIR}/${MODELS_CPT_MODEL}
ENV CPT_BIN_DIR=${MODELS_CPT_DIR}/${MODELS_CPT_VERSION}/bin
ENV SCRIPTS_VERSION=1.9
ENV SCRIPTS_DIR=/forecast/usaid_procesos_interfaz
ENV PYCPT_SCRIPTS_DIR=/forecast/PyCPT
ENV SCRIPTS_NAME=usaid_procesos_interfaz
ENV SCRIPTS_CODE=https://github.com/CIAT-DAPA/usaid_procesos_interfaz/releases/download/v${SCRIPTS_VERSION}/${SCRIPTS_NAME}.zip
ENV PATH="${MODELS_DIR}:${PATH}"
ENV PATH="${CPT_BIN_DIR}:${PATH}"
ENV CONDA_ENV_PYCPT=envpycpt
ENV PATH /root/anaconda3/bin:$PATH

# Install dependencies
# Climate analysis tools: libnetcdf-dev libgrib-api-dev grads cdo nco
RUN apt-get clean \
    && apt-get update \
    && apt-get install -y \
    make \
    gcc \ 
    vim \
    unzip \
    dirmngr \
    software-properties-common \
    apt-transport-https \
    cmake \
    gfortran \
    git \
    wget \
    libnetcdf-dev \
    libgrib-api-dev \
    grads \
    cdo \
    nco \
    r-base \
    gdal-bin \
    proj-bin \
    libgdal-dev \
    libproj-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && wget https://download.visualstudio.microsoft.com/download/pr/647f8505-3bf0-48c5-ac0f-3839be6816d7/d0c2762ded5a1ded3c79b1e495e43b7c/dotnet-sdk-2.2.203-linux-x64.tar.gz \
    && mkdir ~/dotnet-2.2-203 \
    && tar -xvf dotnet-sdk-2.2.203-linux-x64.tar.gz -C ~/dotnet-2.2-203 \
    && ln -s ~/dotnet-2.2-203/dotnet /usr/bin/dotnet \
    && rm dotnet-sdk-2.2.203-linux-x64.tar.gz \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir ${MODELS_WORKDIR} \
    && mkdir ${MODELS_TMP} \
    # Downloading and installing Anaconda
    && wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh \
    && mkdir ~/Anaconda3-2021.11 \
    && mv Anaconda3-2021.11-Linux-x86_64.sh ~/Anaconda3-2021.11 \
    && cd ~/Anaconda3-2021.11 \
    && chmod +x Anaconda3-2021.11-Linux-x86_64.sh \
    && bash Anaconda3-2021.11-Linux-x86_64.sh -b

RUN cp ${MODELS_DIR}/.bashrc ~/.bashrc \
    && /bin/bash -c "source ~/.bashrc" \
    #Installing Anaconda and Python dependencies on a conda enviroment
    && printf "y" | conda create -n ${CONDA_ENV_PYCPT} xarray scipy cartopy netcdf4 numpy scikit-learn  \
    && git clone git@github.com:dimitri-justeau/gsconfig-py3.git \ 
    && cd gsconfig-py3 \ 
    && python setup.py install  \
    && pip install rasterio geopandas

# # Oryza
# RUN cd ${MODELS_DIR} \
#     && unzip ./ORYZAv3_lin.zip \
#     && mv ./Linux ./${MODELS_ORYZA_MODEL} \
#     && chmod +x ${MODELS_DIR}/oryza \
#     && mv ./ORYZAv3_lin.zip ${MODELS_TMP}/ \
# DSSAT
RUN cd ${MODELS_DIR} \ 
    && git clone ${MODELS_DSSAT_GITHUB_URL} \
    && cd ${MODELS_DIR}/${MODELS_DSSAT_GITHUB} \
    && mkdir build \
    && cd build \
    && cmake .. \ 
    && make \
    && mkdir ${MODELS_DSSAT_DIR} \
    && mv ./bin/dscsm047 ${MODELS_DSSAT_DIR}/dscsm047 \
    && cp -r ../Data/. ${MODELS_DSSAT_DIR}/ \
    && mv ${MODELS_DIR}/DSSATPRO.L47 ${MODELS_DSSAT_DIR}/DSSATPRO.L47 \
    && chmod +x ${MODELS_DSSAT_DIR}/dscsm047 \
    && cd ${MODELS_DIR} \
    && mv ${MODELS_DIR}/${MODELS_DSSAT_GITHUB} ${MODELS_TMP}/${MODELS_DSSAT_GITHUB} \
    # CPT and PyCPT scripts
    && cd ${MODELS_DIR} \ 
    && mkdir -p /${MODELS_CPT_MODEL}/${MODELS_CPT_VERSION} \
    && tar xzvf ${MODELS_CPT_SOURCE} \
    && cd ${MODELS_CPT_DIR}/${MODELS_CPT_VERSION} \
    && make distclean \
    && make \
    && make ${MODELS_CPT_DIR}/${MODELS_CPT_VERSION}=~ install \
    && cd ${MODELS_DIR} \
    && mv ${MODELS_DIR}/${MODELS_CPT_SOURCE} ${MODELS_TMP}/ \
    && mkdir ${PYCPT_SCRIPTS_DIR} \
    && cd ${PYCPT_SCRIPTS_DIR} \
    && git clone https://bitbucket.org/py-iri/iri-pycpt.git \
    # Scripts usaid_procesos_interfaz
    && mkdir ${SCRIPTS_DIR} \    
    && cd ${SCRIPTS_DIR} \ 
    && wget ${SCRIPTS_CODE} \
    && unzip ${SCRIPTS_NAME}.zip \
    && rm ${SCRIPTS_NAME}.zip \
    && Rscript ${MODELS_DIR}/imports.R \
    && mv ${MODELS_DIR}/imports.R ${MODELS_TMP}/ \
    && mv ${MODELS_DIR}/pkgs.rds ${MODELS_TMP}/


# Observations:
# CPT.17.6.1
# GNU Fortran (Debian 8.3.0-6) 8.3.0
# Anaconda3-2021.11-Linux
# PyCPT (last commit on master branch at 13/01/2022)
# CPT, Gfortran, Anaconda and PyCPT are the last versions used a this date (01/02/2022)
# Docs: https://bitbucket.org/py-iri/iri-pycpt/wiki/PyCPT%20Detailed%20Instructions

# docker build -t stevensotelo/aclimate_process:2.0 .
# docker tag 0a1002a8a03d stevensotelo/aclimate_process:2.0

# docker run -it --rm -v D:/CIAT/Code/USAID/usaid_forecast_docker/forecast_process/workdir:/forecast/workdir stevensotelo/aclimate_process:latest /bin/bash 
# docker run -it --rm -e N_CORES=2 -v D:/CIAT/Code/USAID/usaid_forecast_docker/forecast_process/workdir:/forecast/workdir stevensotelo/aclimate_process:2.0 /bin/bash
# docker run -it --rm -e N_CORES=5 --cpus="5" --mount type=bind,source=/opt/aclimate/1.Data/forecast/202110,destination=/forecast/workdir stevensotelo/aclimate_process:latest /bin/bash