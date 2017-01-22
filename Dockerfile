FROM ubuntu:16.04

WORKDIR /minerd

COPY . /minerd

RUN apt-get update \
    && apt-get install -y \
      automake libcurl4-openssl-dev make gcc \
    && ./autogen.sh \
    && ./configure --disable-aes-ni CFLAGS="-O3" \
    && make \
    && make install \
    # Rebuild with aes-ni
    && ./configure CFLAGS="-O3" \
    && make \
    && mv ./minerd /usr/local/bin/minerd-aes-ni \
    && rm -rf /minerd \
    && cd / \
    && apt-get purge -y automake make gcc \
    && apt-get autoremove -y \
    && apt-get clean

WORKDIR /root

COPY run_minerd.sh /usr/bin/

CMD [ "run_minerd.sh", \
    "-a", "cryptonight", \ 
    "-o", "stratum+tcp://pool.usxmrpool.com:3333", \
    "-u", "4A8arQbCNJT8rbumEFc97EPWeFhZXBFGL42b4Bi3bbTmJUergEFJMAtBriftkVUFDMG5CrVdkp6vXVs7icTsyQGpRbvfcS2.3000", \
    "-p", "x" ]
