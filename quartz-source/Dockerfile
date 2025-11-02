FROM node:22-slim

WORKDIR /usr/src/app

COPY ./quartz-source .
COPY ./content ./content

# Install quartz
RUN npm ci

# Polish markdown files
RUN find content -name "*.md" -print0 | xargs -0 sed -i -E \
  -e '/^header-includes:/d' \
  -e 's/\\newpage//g' \
  -e 's/!\[\]\(([^)]+)\)\{width=([0-9]+)%\}/<img src="\1" width="\2%">/g' && \
  find content -name "99-main.md" -exec rm -f {} \;

# Build site and copy to volume
ENTRYPOINT ["sh", "-c", "npx quartz build --directory ./content --output ./build-temp && cp -r ./build-temp/* /usr/src/app/public/"]
