FROM scratch

ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="satoshi-devtools" \
      org.opencontainers.image.description="Image containing approved versions of tools used with apps running on Mintel's Satoshi platform." \
      org.opencontainers.image.version="0.1.0" \
      org.opencontainers.image.vendor="Mintel Group Ltd." \
      org.opencontainers.image.authors="Bobby Brockway <bbrockway@mintel.com>" \
      org.opencontainers.image.source="https://github.com/mintel/satoshi-devtools" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.revision=$VCS_REF

COPY --from=mintel/kubelock:0.1.0 /usr/local/bin/kubelock /usr/local/bin/
COPY --from=banzaicloud/vault-env:0.7.1 /usr/local/bin/vault-env /usr/local/bin/
