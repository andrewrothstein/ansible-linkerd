#!/usr/bin/env bash
set -e
#set -x
MIRROR=https://github.com/linkerd/linkerd2/releases/download

dl()
{
    local branch=$1
    local ver=$2
    local os=$3
    local arch=$4
    local suffix=${5:-}
    local platform="${os}-${arch}"
    local infix=$platform
    if [ "${arch}" = "amd64" ] && [ "$os" = "darwin" ] || [ "$os" = "windows" ];
    then
        infix="$os"
    fi
    local url=$MIRROR/${branch}-${ver}/linkerd2-cli-$branch-$ver-$infix$suffix.sha256
    printf "      # %s\n" $url
    printf "      %s: sha256:%s\n" $platform $(curl -sSLf $url | awk '{print $1}')
}

dl_ver() {
    local branch=$1
    local ver=$2
    printf "    '%s':\n" $ver
    dl $branch $ver darwin amd64
    dl $branch $ver darwin arm64
    dl $branch $ver linux amd64
    dl $branch $ver linux arm
    dl $branch $ver linux arm64
    dl $branch $ver windows amd64 .exe
}

#printf "  %s:\n" stable
dl_ver stable ${1:-2.13.0}
#printf "  %s:\n" edge
#dl_ver edge 20.1.4
