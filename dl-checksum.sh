#!/usr/bin/env sh
#set -x
MIRROR=https://github.com/linkerd/linkerd2/releases/download

dl()
{
    local branch=$1
    local ver=$2
    local os=$3
    local suffix=${4:-}
    local url=$MIRROR/${branch}-${ver}/linkerd2-cli-$branch-$ver-$os$suffix.sha256
    printf "      # %s\n" $url
    printf "      %s: sha256:%s\n" $os `curl -sSL $url | awk '{print $1}'`

}

dl_ver() {
    local branch=$1
    local ver=$2
    printf "    '%s':\n" $ver
    dl $branch $ver darwin
    dl $branch $ver linux
    dl $branch $ver windows .exe
}

printf "  %s:\n" stable
dl_ver stable ${1:-2.8.1}
#printf "  %s:\n" edge
#dl_ver edge 20.1.4
