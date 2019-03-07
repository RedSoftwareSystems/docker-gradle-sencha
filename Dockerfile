#from gradle:5.2.1-jdk8
from openjdk:8-jdk

LABEL maintainer "Luca Botti <lbotti@red.software.systems>"

ENV SENCHA_CMD_VERSION=6.7.0.37

ENV GRADLE_HOME /opt/gradle
ENV GRADLE_VERSION 5.2.1

ARG GRADLE_DOWNLOAD_SHA256=748c33ff8d216736723be4037085b8dc342c6a0f309081acf682c9803e407357
RUN set -o errexit -o nounset \
    && echo "Downloading Gradle" \
    && wget --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
    \
    && echo "Checking download hash" \
    && echo "${GRADLE_DOWNLOAD_SHA256} *gradle.zip" | sha256sum --check - \
    \
    && echo "Installing Gradle" \
    && unzip gradle.zip \
    && rm gradle.zip \
    && mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
    && ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle \
    \
    && echo "Adding gradle user and group" \

    \
    && echo "Symlinking root Gradle cache to gradle Gradle cache" \
    && mkdir /project




RUN curl -o /cmd.run.zip http://cdn.sencha.com/cmd/$SENCHA_CMD_VERSION/no-jre/SenchaCmd-$SENCHA_CMD_VERSION-linux-amd64.sh.zip && \
    unzip -p /cmd.run.zip > /cmd-install.run && \
    chmod +x /cmd-install.run && \
    /cmd-install.run -q -dir /opt/Sencha/Cmd/$SENCHA_CMD_VERSION &&\
    rm /cmd-install.run /cmd.run.zip &&\
    ln -s /opt/Sencha/Cmd/$SENCHA_CMD_VERSION/sencha /opt/Sencha/sencha && \
    ln -s /opt/Sencha/Cmd/$SENCHA_CMD_VERSION/sencha /usr/local/bin/sencha && \
    apt-get update && apt-get upgrade -y

# Create Gradle volume

WORKDIR /project

RUN set -o errexit -o nounset \
    && echo "Testing Gradle installation" \
    && gradle --version

#ENTRYPOINT ["/opt/Sencha/sencha"]


