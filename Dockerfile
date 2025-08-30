
## the Dockerfile from master branch use Amz Corretto, old 8, 23 (non LTS) get python 3.9
## but then the wget for varscan is 404...
## so Debian base and use apt to get such package maybe easier to maintain.

## package req per https://snp-pipeline.readthedocs.io/en/latest/installation.html

##FROM debian:stretch
#FROM debian:bullseye  11 old old stable
#FROM debian:bookworm  12     old stable
#FROM debian:trixie    13 current stable
FROM debian:trixie


## unofficial containerazation of FDA's CFSAN SNP Pipeline
## install ref: https://snp-pipeline.readthedocs.io/en/latest/installation.html

ENV DEBIAN_FRONTEND noninteractive


### RUN set -ex; \

RUN echo  ''  ;\
    touch _TOP_DIR_OF_CONTAINER_  ;\
    echo  'debian_bullseye'                  | tee -a _TOP_DIR_OF_CONTAINER_ ;\
    echo "begining docker build process at " | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    date | tee -a       _TOP_DIR_OF_CONTAINER_ ;\
    export TERM=dumb      ;\
    export NO_COLOR=TRUE  ;\
    cd /     ;\
    echo "" 


RUN echo  ''  ;\
    touch _TOP_DIR_OF_CONTAINER_  ;\
    echo "This container build as os, then add additional package via standalone shell script " | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    export TERM=dumb      ;\
    export NO_COLOR=TRUE  ;\
    apt-get update ;\
    apt-get -y --quiet install git git-all file wget curl gzip bash zsh fish tcsh less vim procps screen tmux ;\
    apt-get -y --quiet install apt-file ;\
    cd /    ;\
    echo ""

# bulleye don't have htop, btop, usbtop that ubuntu does
# actualy have htop
# tabix need trixie (ver 13, current stable).  should have just named this branch deb rather than deb11... change tbd
# top is from init-system-helpers

RUN echo  ''  ;\
    touch _TOP_DIR_OF_CONTAINER_  ;\
    export TERM=dumb      ;\
    export NO_COLOR=TRUE  ;\
    apt-get update -qq; \
    apt-get install -y -qq git \
    apt-utils \
    wget \
    init-system-helpers \
    python3-pip \
    python3-dev \
    bowtie2 \
    smalt \
    smalt-examples \
    samtools samtools-test \
    picard picard-tools \
    varscan \
    tabix \
    bcftools \
    ; \
    rm -rf /var/cache/apt/* /var/lib/apt/lists/*;

#btop \

ENV DEBIAN_FRONTEND Teletype

# Install python dependencies
#++RUN pip3 install -U snp-pipeline;
#Sn50 ^^ error... exit 127 

#Sn50
# Install GATK 
RUN cd /opt ;\
    make gatk ;\
    wget -q -O gatk.zip https://github.com/broadinstitute/gatk/releases/download/4.6.2.0/gatk-4.6.2.0.zip ;\
    unzip gatk.zip ;\
    echo $? 


# gatk-4.6.2.0.zip

#COPY cgMLST.py /usr/src/cgMLST.py

#RUN chmod 755 /usr/src/cgMLST.py;



#Sn50

ENV DBG_CONTAINER_VER  "Dockerfile 2025.0830 sn50"
ENV DBG_DOCKERFILE Dockerfile

RUN  cd / \
  && touch _TOP_DIR_OF_CONTAINER_  \
  && echo  "--------" >> _TOP_DIR_OF_CONTAINER_   \
  && TZ=PST8PDT date  >> _TOP_DIR_OF_CONTAINER_   \
  && uptime    | tee -a  _TOP_DIR_OF_CONTAINER_   \
  && echo  $DBG_CONTAINER_VER   | tee -a  _TOP_DIR_OF_CONTAINER_   \
  && echo  "Grand Finale for Dockerfile"



ENV PATH $PATH:/usr/src
# Setup .bashrc file for convenience during debugging
RUN echo "alias ls='ls -h --color=tty'\n"\
"alias ll='ls -lrt'\n"\
"alias l='less'\n"\
"alias du='du -hP --max-depth=1'\n"\
"alias cwd='readlink -f .'\n"\
"PATH=$PATH\n">> ~/.bashrc

WORKDIR /workdir


#export CLASSPATH=~/software/varscan.v2.3.9/VarScan.jar:$CLASSPATH
#export CLASSPATH=~/software/picard/picard.jar:$CLASSPATH
#export CLASSPATH=~/software/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar:$CLASSPATH

#ENV CLASSPATH /opt/gatk/

# Execute program when running the container
#ENTRYPOINT ["python3", "/usr/src/cgMLST.py"]
ENTRYPOINT ["/bin/bash"]

