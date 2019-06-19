#!/usr/bin/env sh
BRANCH=stable
VER=2.3.1
MIRROR=https://github.com/linkerd/linkerd2/releases/download/stable-${VER}

dl()
{
    OS=$1
    SUFFIX=${2:-}
    URL=$MIRROR/linkerd2-cli-$BRANCH-$VER-$OS$SUFFIX.sha256
    printf "    # %s\n" $URL
    printf "    %s: sha256:%s\n" $OS `curl -sSL $URL | awk '{print $1}'`

}

printf "%s:\n" $BRANCH
printf "  '%s':\n" $VER
dl darwin
dl linux
dl windows .exe

