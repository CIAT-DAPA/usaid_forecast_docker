FROM stevensotelo/aclimate_process:2.1prod

LABEL maintainer="stevenbetancurt@hotmail.com"

WORKDIR /forecast

COPY ./models /forecast/models
# COPY ./forecast_process/test /forecast/test/

ENV MODELS_DIR=/forecast/models
ENV MODELS_TMP=/forecast/tmp
ENV MODELS_WORKDIR=/forecast/workdir
ENV MODELS_DSSAT_MODEL=dssat-csm
ENV MODELS_DSSAT_GITHUB=dssat-csm-os
ENV MODELS_DSSAT_GITHUB_URL=https://github.com/DSSAT/dssat-csm-os
ENV MODELS_DSSAT_DIR=${MODELS_DIR}/${MODELS_DSSAT_MODEL}
ENV MODELS_CPT_MODEL=CPT
ENV MODELS_CPT_VERSION=15.5.3
ENV MODELS_CPT_SOURCE=${MODELS_CPT_MODEL}.${MODELS_CPT_VERSION}.tar.gz
ENV MODELS_CPT_DIR=${MODELS_DIR}/${MODELS_CPT_MODEL}
ENV CPT_BIN_DIR=${MODELS_CPT_DIR}/${MODELS_CPT_VERSION}/bin
ENV SCRIPTS_VERSION=2.2
ENV SCRIPTS_DIR=/forecast/usaid_procesos_interfaz
ENV PYCPT_SCRIPTS_DIR=/forecast/PyCPT
ENV SCRIPTS_NAME=usaid_procesos_interfaz
ENV SCRIPTS_CODE=https://github.com/CIAT-DAPA/usaid_procesos_interfaz/releases/download/v${SCRIPTS_VERSION}/${SCRIPTS_NAME}.zip
ENV PATH="${MODELS_DIR}:${PATH}"
ENV PATH="${CPT_BIN_DIR}:${PATH}"
ENV CONDA_ENV_PYCPT=envpycpt
ENV PATH /root/anaconda3/bin:$PATH

#Activating conda env and installing python dependencies
SHELL ["conda", "run", "-n", "envpycpt", "/bin/bash", "-c"]
# CPT and PyCPT scripts
RUN cd ${MODELS_DIR} \ 
    && mkdir -p /${MODELS_CPT_MODEL}/${MODELS_CPT_VERSION} \
    && tar xzvf ${MODELS_CPT_SOURCE} \
    && cd ${MODELS_CPT_DIR}/${MODELS_CPT_VERSION} \
    && make distclean \
    && make \
    && make ${MODELS_CPT_DIR}/${MODELS_CPT_VERSION}=~ install \
    && cd ${MODELS_DIR} \
    && mv ${MODELS_DIR}/${MODELS_CPT_SOURCE} ${MODELS_TMP}/ \
    # Scripts usaid_procesos_interfaz
    && rm -r ${SCRIPTS_DIR} \
    && mkdir ${SCRIPTS_DIR} \        
    && cd ${SCRIPTS_DIR} \ 
    && wget ${SCRIPTS_CODE} \
    && unzip ${SCRIPTS_NAME}.zip \
    && rm ${SCRIPTS_NAME}.zip \
    ## Instaling new packages for new prediction script
    && pip install git+https://github.com/CIAT-DAPA/aclimate_cpt \ 
    && pip install git+https://github.com/CIAT-DAPA/aclimate_resampling \
    && pip install git+https://github.com/CIAT-DAPA/aclimate_crop_risk_indices \
    && pip install --upgrade pandas "dask[complete]"
    # && printf "y" | pip install pandas==1.4.2 tqdm==4.62.3 numpy==1.25.2 opencv-python==4.8.0.76 matplotlib==3.5.1 requests==2.27.1 datetime==4.3 xarray==0.20.2 dask==2023.1.0 \

# Observations:
# CPT.17.6.1
# GNU Fortran (Debian 8.3.0-6) 8.3.0
# Anaconda3-2021.11-Linux
# PyCPT (last commit on master branch at 13/01/2022)
# CPT, Gfortran, Anaconda and PyCPT are the last versions used a this date (01/02/2022)
# Docs: https://bitbucket.org/py-iri/iri-pycpt/wiki/PyCPT%20Detailed%20Instructions

# docker build -t stevensotelo/aclimate_process:2.1 .
# docker tag 0a1002a8a03d stevensotelo/aclimate_process:2.1

# docker run -it --rm -v D:/CIAT/Code/USAID/usaid_forecast_docker/forecast_process/workdir:/forecast/workdir stevensotelo/aclimate_process:latest /bin/bash 
# docker run -it --rm -e N_CORES=2 -v D:/CIAT/Code/USAID/usaid_forecast_docker/forecast_process/workdir:/forecast/workdir stevensotelo/aclimate_process:2.0 /bin/bash
# docker run -it --rm -e N_CORES=5 --cpus="5" --mount type=bind,source=/opt/aclimate/1.Data/forecast/202110,destination=/forecast/workdir stevensotelo/aclimate_process:latest /bin/bash