FROM adoptopenjdk/openjdk17:alpine

# Environment variables
ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools


RUN apk add --no-cache bash curl unzip
RUN mkdir -p ${ANDROID_SDK_ROOT} && \
    cd ${ANDROID_SDK_ROOT} && \
    curl -o sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip && \
    unzip sdk-tools.zip && \
    rm sdk-tools.zip
    
RUN yes | ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager "build-tools;32.0.0" "cmdline-tools;latest" "emulator" "patcher;v4" "platform-tools" "platforms;android-31" "system-images;android-31;google_apis;x86_64"

RUN yes | ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --licenses

EXPOSE 5037

WORKDIR /workspace

CMD ["/bin/bash"]
