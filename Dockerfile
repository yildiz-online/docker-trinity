FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
RUN git clone -b 3.3.5 git://github.com/TrinityCore/TrinityCore.git

FROM moussavdb/build-java-native as build
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
COPY --from=clone /app/TrinityCore /app
RUN apt-get install libssl-dev libbz2-dev libreadline-dev libncurses-dev libboost-all-dev libmysqlclient-dev git -y -q
RUN mkdir /app/build
WORKDIR /app/build
RUN cmake ..

FROM ubuntu:bionic
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
COPY --from=build /app/build /app
