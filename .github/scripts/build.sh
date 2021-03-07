BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')
VCS_REF=$GITHUB_SHA

for file in $(ls *.dockerfile)
do
  TAG=${file%.*}

  docker build \
    --file $file \
    --build-arg BUILD_DATE=$BUILD_DATE \
    --build-arg VCS_REF=$GITHUB_SHA \
    --tag $REPO:$TAG \
    .

  docker push $REPO:$TAG

  TAG=$TAG-dev
  docker build \
    --file $file \
    --build-arg BUILD_DATE=$BUILD_DATE \
    --build-arg VCS_REF=$GITHUB_SHA \
    --tag $REPO:$TAG \
    --target dev \
    .

  docker push $REPO:$TAG
done
