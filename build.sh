#!/bin/bash

# Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.

# WSO2 Inc. licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

function showUsageAndExit() {
    echo "Insufficient or invalid options provided"
    echo
    echo "Usage: "$'\e[1m'"./build.sh -t [target-file] -v [build-version] -f"$'\e[0m'
    echo -en "  -t\t"
    echo "[REQUIRED] Target file to build."
    echo -en "  -v\t"
    echo "[REQUIRED] Build version. If not specified a default value will be used."
    echo -en "  -f\t"
    echo "[OPTIONAL] Cross compile for all the list of platforms. If not specified, the specified target file will be cross compiled only for the autodetected native platform."

    echo
    echo "Ex: "$'\e[1m'"./build.sh -t main.go -v 1.0.0 -f"$'\e[0m'" - Builds Client for version 1.0.0 for all the platforms"
    echo
    exit 1
}

function detectPlatformSpecificBuild() {
    platform=$(uname -s)
    if [[ "${platform}" == "Linux" ]]; then
        platforms="linux/386/linux/i586 linux/amd64/linux/x64"
    elif [[ "${platform}" == "Darwin" ]]; then
        platforms="darwin/amd64/macosx/x64"
    else
        platforms="windows/386/windows/i586 windows/amd64/windows/x64"
    fi
}

while getopts :t:v:f FLAG; do
  echo "hiiiiN"
  case $FLAG in
    t)
      target=$OPTARG
      ;;
    v)
      build_version=$OPTARG
      ;;
    f)
      full_build="true"
      ;;
    \?)
      showUsageAndExit
      ;;
  esac
done

if [ ! -e "$target" ]; then
  echo "Target file is needed. "
  showUsageAndExit
  exit 1
fi

if [ -z "$build_version" ]
then
  echo "Build version is needed. "
  showUsageAndExit
fi

rootPath=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
buildDir="build/target"
buildPath="$rootPath/${buildDir}"

echo "Cleaning build path ${buildDir}..."
rm -rf $buildPath

type glide >/dev/null 2>&1 || { echo >&2 "Glide dependency management is needed to build the WUM Client (https://glide.sh/).  Aborting."; exit 1; }
echo "Setting up dependencies..."
glide install
echo

#filename=$(basename ${target})
#baseDir=$(dirname ${target})
#if [ ".go" == ${filename:(-3)} ]
#then
#    filename=${filename%.go}
#fi
#
##platforms="darwin/amd64 freebsd/386 freebsd/amd64 freebsd/arm linux/386 linux/amd64 linux/arm windows/386 windows/amd64"
##platforms="linux/amd64/linux/x64"
##platforms="darwin/amd64/macosx/x64"
#if [ "${full_build}" == "true" ]; then
#    echo "Building "$'\e[1m'"${filename^^}:${build_version}"$'\e[0m'" for all platforms..."
#    platforms="darwin/amd64/macosx/x64 linux/386/linux/i586 linux/amd64/linux/x64 windows/386/windows/i586 windows/amd64/windows/x64"
#else
#    detectPlatformSpecificBuild
#    echo "Building "$'\e[1m'"${filename^^}:${build_version}"$'\e[0m'" for detected "$'\e[1m'"${platform}"$'\e[0m'" platform..."
#fi
#
#for platform in ${platforms}
#do
#    split=(${platform//\// })
#    goos=${split[0]}
#    goarch=${split[1]}
#    pos=${split[2]}
#    parch=${split[3]}
#
#    # ensure output file name
#    output="$binary"
#    test "$output" || output="$(basename ${target} | sed 's/\.go//')"
#
#    # add exe to windows output
#    [[ "windows" == "$goos" ]] && output="$output.exe"
#
#    echo -en "\t - $goos/$goarch..."
#
#    zipfile="$filename-$build_version-$pos-$parch"
#    zipdir="${buildPath}/$filename"
#    mkdir -p $zipdir
#
#    cp -r "${baseDir}/resources/README.txt" $zipdir > /dev/null 2>&1
#    cp -r "${baseDir}/resources/LICENSE.txt" $zipdir > /dev/null 2>&1
#
#    # set destination path for binary
#    destination="$zipdir/bin/$output"
#
#    #echo "GOOS=$goos GOARCH=$goarch go build -x -o $destination $target"
#    GOOS=$goos GOARCH=$goarch go build -gcflags=-trimpath=$GOPATH -asmflags=-trimpath=$GOPATH -ldflags "-X main.wumVersion=$build_version -X 'main.buildDate=$(date -u '+%Y-%m-%d %H:%M:%S UTC')'" -o $destination $target
#    cp -r "${baseDir}/resources/wum-admin.yaml.sample" "${zipdir}/bin" > /dev/null 2>&1
#
#    pwd=`pwd`
#    cd $buildPath
#    tar czf "$zipfile.tar.gz" $filename > /dev/null 2>&1
#    rm -rf $filename
#    cd $pwd
#    echo -en $'\e[1m\u2714\e[0m'
#    echo
done

echo "Build complete!"
© 2020 GitHub, Inc.