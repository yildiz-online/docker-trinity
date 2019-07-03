FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
RUN git clone -b 3.3.5 git://github.com/TrinityCore/TrinityCore.git

FROM moussavdb/build-java-native as build
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
COPY --from=clone /app/TrinityCore /app
COPY /app/build.sh /app
RUN ls -l
RUN chmod +x build.sh
RUN ./build.sh

FROM ubuntu:bionic
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
COPY --from=build /app/build /app
