FROM debian:stretch

RUN apt-get update && apt-get install -y wget git build-essential

RUN echo "Building pdf2json"
RUN wget -Opdf2json-0.70.tar.gz -q https://github.com/flexpaper/pdf2json/releases/download/0.70/pdf2json-0.70.tar.gz \
  && mkdir pdf2json \
  && tar -xzf pdf2json-0.70.tar.gz -C pdf2json/ \
  && cd pdf2json \
  && chmod +x configure \
  && ./configure \
  && make \ 
  && make install

RUN echo "Building MuPDF"
RUN git clone --recursive git://git.ghostscript.com/mupdf.git \
  && cd mupdf \
  && git submodule update --init \
  && make HAVE_X11=no HAVE_GLUT=no prefix=/usr/local install
