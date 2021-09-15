FROM alpine:latest

MAINTAINER andy <andycrusoe@gmail.com>

ENV GOPATH /home/developer/workspace
ENV GOROOT /usr/lib/go
ENV GOBIN $GOROOT/bin
ENV PATH $PATH:$GOBIN:$GOPATH/bin

RUN apk --no-cache add git mercurial gcc g++               && \
    apk --update add go --update-cache --repository         \
      http://dl-3.alpinelinux.org/alpine/edge/community  && \
    mkdir -p /home/developer/workspace/bin && \
    go env -w GOPROXY=https://goproxy.cn,direct
    
RUN go get -u -buildmode=exe -ldflags '-s -w'               \
      golang.org/x/tools/cmd/benchcmp                       \
      golang.org/x/tools/cmd/bundle                         \
      golang.org/x/tools/cmd/callgraph                      \
      golang.org/x/tools/cmd/cover                          \
      golang.org/x/tools/cmd/digraph                        \
      golang.org/x/tools/cmd/eg                             \
      golang.org/x/tools/cmd/fiximports                     \
      golang.org/x/tools/cmd/godex                          \
      golang.org/x/tools/cmd/godoc                          \
      golang.org/x/tools/cmd/goimports                      \
      golang.org/x/tools/cmd/gomvpkg                        \
      golang.org/x/tools/cmd/gorename                       \
      golang.org/x/tools/cmd/gotype                         \
      golang.org/x/tools/cmd/html2article                   \
       golang.org/x/tools/cmd/guru                          \
      golang.org/x/tools/cmd/present                        \
      golang.org/x/tools/cmd/ssadump                        \
      golang.org/x/tools/cmd/stress                         \
      golang.org/x/tools/cmd/stringer                       \
      golang.org/x/tools/refactor/eg                        \
      golang.org/x/tools/refactor/importgraph               \
      golang.org/x/tools/refactor/rename                    \
      golang.org/x/tools/refactor/satisfy                   \
      github.com/rogpeppe/godef                             \
      github.com/tools/godep                                \
      github.com/nsf/gocode                                 \
      github.com/kisielk/errcheck                           \
      golang.org/x/lint \
      github.com/jstemmer/gotags                            \
      github.com/dougm/goflymake                            \
      github.com/golang/mock/mockgen                        
#      github.com/alecthomas/gometalinter                 

RUN gometalinter --install --update                      && \
    apk del git mercurial gcc                            && \
    find / -name ".git" -prune -exec rm -rf "{}" \;      && \
    rm -rf /var/cache/apk/* /home/developer/workspace/*

WORKDIR /home/developer/workspace/
