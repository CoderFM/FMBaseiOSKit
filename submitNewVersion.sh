#! /bin/bash
basePath=$(cd "$(dirname "$0")";pwd)
cd $basePath
pod repo push FMPodSpec FMBaseiOSKit.podspec --allow-warnings &&
pod trunk push FMBaseiOSKit.podspec --allow-warnings

