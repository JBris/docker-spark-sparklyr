ARG TIDYVERSE_TAG

FROM rocker/tidyverse:${TIDYVERSE_TAG}

ENV DEBIAN_FRONTEND=noninteractive

ENV SPARK_HOME="/home/rstudio/spark/spark-3.5.0-bin-hadoop3"

RUN apt-get update -y \ 
  && apt-get install -y --no-install-recommends openjdk-17-jdk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/downloaded_packages \
  && install2.r -n -1 --skipinstalled -r "http://cran.us.r-project.org" sparklyr future modeldata \
  && Rscript -e 'options(timeout=1e5); sparklyr::spark_install("3.5")' \
  && strip /usr/local/lib/R/site-library/*/libs/*.so

