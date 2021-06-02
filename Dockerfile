FROM scratch

ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="satoshi-devtools" \
      org.opencontainers.image.description="Image containing approved versions of tools used with apps running on Mintel's Satoshi platform." \
      org.opencontainers.image.version="1.4.0" \
      org.opencontainers.image.vendor="Mintel Group Ltd." \
      org.opencontainers.image.authors="Bobby Brockway <bbrockway@mintel.com>" \
      org.opencontainers.image.source="https://github.com/mintel/satoshi-devtools" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.revision=$VCS_REF

COPY --from=mintel/kubelock:mod-update /usr/local/bin/kubelock /usr/local/bin/
COPY --from=banzaicloud/vault-env:1.2.0 /usr/local/bin/vault-env /usr/local/bin/
COPY ./scripts/wait-for-mysql.py /usr/local/bin/
