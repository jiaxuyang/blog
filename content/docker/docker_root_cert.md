---
title: "docker根证书"
date: 2020-09-21T14:49:06+08:00
---
证书问题
直接安装：RUN apk --no-cache add ca-certificates
也可以从之前的stage复制：COPY --from=build-env /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/