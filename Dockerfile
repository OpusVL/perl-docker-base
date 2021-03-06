FROM debian:jessie
MAINTAINER Colin Newell <colin@opusvl.com>
USER root
RUN apt-get update && apt-get install -y build-essential libexpat1-dev libpq-dev \
            libxml2-dev psmisc unzip less libjpeg62-turbo-dev libpng12-dev curl wget &&\
    apt-get dist-upgrade -y
RUN mkdir /opt/perl-5.20.3 && \
    mkdir /opt/perl-5.20.3/bin && \
    mkdir /opt/perl-5.20.3/lib && \
    mkdir /opt/perl-5.20.3/man
RUN ln -s /opt/perl-5.20.3 /opt/perl5
WORKDIR /root
RUN wget https://cpan.metacpan.org/authors/id/S/SH/SHAY/perl-5.20.3.tar.bz2 &&\
    tar -jxf perl-5.20.3.tar.bz2 && rm perl-5.20.3.tar.bz2 &&\
    cd /root/perl-5.20.3 && ./Configure -des -Dprefix=/opt/perl-5.20.3 && \
    make && make test && make install && rm -rf /root/perl-5.20.3
RUN cd /root; curl -L https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm | /opt/perl5/bin/perl - --self-upgrade
