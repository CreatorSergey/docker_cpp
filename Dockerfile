FROM gcc:latest as build

RUN apt-get update && \
    apt-get install -y \
    libboost-dev libboost-chrono-dev \
    cmake

ADD ./src /app/src

WORKDIR /app/build

RUN cmake ../src && \
    cmake --build .

FROM ubuntu:latest

WORKDIR /app

COPY --from=build /app/build/example .

ENTRYPOINT [ "./example" ]