FROM docker.io/pandoc/extra:3.7

# Copy entrypoint
COPY ./formatting.lua /opt/formatting.lua
COPY ./header.tex /opt/header.tex
COPY ./build-pdfs.sh /opt/build-pdfs.sh

# Installing dependencies
RUN tlmgr update --self && tlmgr install pdfcol

ENTRYPOINT ["/opt/build-pdfs.sh"]
