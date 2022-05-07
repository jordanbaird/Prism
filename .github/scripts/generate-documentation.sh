#!/bin/bash

swift package \
  --allow-writing-to-directory ./docs \
    generate-documentation \
      --target Prism \
      --disable-indexing \
      --transform-for-static-hosting \
      --hosting-base-path Prism \
      --output-path ./docs
