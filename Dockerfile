FROM alpine as build

RUN apk add --no-cache --virtual build-dependencies \
    git \
    build-base \
    cmake

ENV EIGEN_VERSION 3.3.8

RUN git clone --depth 1 --branch ${EIGEN_VERSION} https://gitlab.com/libeigen/eigen.git /eigen

WORKDIR /eigen/build
RUN cmake \
    -DCMAKE_INSTALL_PREFIX=/opt/eigen \
    ..
RUN make
RUN make install

FROM alpine

COPY --from=build /opt/eigen/ /opt/eigen/

ENV C_INCLUDE_PATH /usr/include/:/opt/eigen/include/

