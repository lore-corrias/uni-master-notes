FROM docker.io/pandoc/extra:latest

# Copy entrypoint
COPY ./build-pdfs.sh /opt/build-pdfs.sh

# Installing dependencies
RUN tlmgr install pdfcol

# Installing the LUA Callout filter
RUN wget -O /opt/callout.lua "https://raw.githubusercontent.com/zcysxy/obsidian-pandoc-filters/refs/heads/main/filters/callout.lua"

ENTRYPOINT ["/opt/build-pdfs.sh"]
