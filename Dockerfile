FROM rocker/r-ver:4.1.3

RUN apt-get update -y && \
    apt-get install -y libcairo2-dev \
        libxt-dev \
        pandoc && \
    rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c( \
                'dplyr', 'tidyr', \
                'tibble', 'ggplot2', \
                'purrr', 'data.table', \
                'knitr', 'BiocManager', \
                'plotly', 'bit64', \
                'RColorBrewer', 'stringr', \
                'Cairo', 'scales', \
                'scales', 'jsonlite', \
                'htmltools', 'fontawesome', \
                'crosstalk', 'remotes'))" \
    && R -e "remotes::install_github('jokergoo/circlize')" \
    && R -e "remotes::install_github(c( \
        'jokergoo/ComplexHeatmap', \
        'glin/reactable', \
        'rstudio/rmarkdown'))"

ADD R/ /R/

WORKDIR /data