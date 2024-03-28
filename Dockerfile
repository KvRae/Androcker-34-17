FROM adoptopenjdk/openjdk17:alpine


ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/tools/bin

RUN apk --no-cache add \
    bash \
    curl \
    git \
    unzip

RUN mkdir -p ${ANDROID_SDK_ROOT} \
    && cd ${ANDROID_SDK_ROOT} \
    && curl -o sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip \
    && unzip sdk-tools.zip \
    && rm sdk-tools.zip
    
RUN yes | sdkmanager --licenses

RUN sdkmanager "platforms;android-34"

RUN rm -rf /var/cache/apk/* \
    && rm -rf ${ANDROID_SDK_ROOT}/tools
    
WORKDIR /app
