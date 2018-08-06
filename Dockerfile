FROM debian:9.5
MAINTAINER OpusVL <support@opusvl.com>
USER root

RUN apt-get update && apt-get install -y build-essential libexpat1-dev libpq-dev \
            libxml2-dev psmisc unzip less libjpeg62-turbo-dev libpng-dev curl wget &&\
    apt-get dist-upgrade -y

ARG version

WORKDIR /root
RUN wget http://www.cpan.org/src/5.0/perl-5.26.2.tar.gz \
    && tar -xzf perl-5.26.2.tar.gz \
    && cd perl-5.26.2 \
    && ./Configure -des -Dprefix=/opt/perl-5.26.2 \
    && make \
    && make test \
    && make install
RUN rm -rf perl-5.26.2.tar.gz perl-5.26.2
RUN ln -s /opt/perl-5.26.2 /opt/perl5
RUN curl -L https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm | /opt/perl5/bin/perl - --self-upgrade
