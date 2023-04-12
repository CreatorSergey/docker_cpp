FROM --platform=$TARGETPLATFORM debian as build

ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM" > /log

RUN apt-get update && \
    apt-get install -y \
    libboost-dev libboost-chrono-dev \
    cmake

RUN apt-get -y install sudo
RUN sudo apt-get -y install build-essential

ADD ./src /app/src

WORKDIR /app/build

RUN cmake ../src && \
    cmake --build .

FROM --platform=$TARGETPLATFORM debian

WORKDIR /app

COPY --from=build /app/build/example .
COPY --from=build /app/src/entry.sh entry.sh

ENTRYPOINT [ "./entry.sh" ]