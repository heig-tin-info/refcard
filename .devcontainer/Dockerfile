FROM alpine:3.20.2

ARG TL_YEAR=2023
ARG TL_SCHEME="scheme-minimal"

ARG TL_MIRROR="http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/${TL_YEAR}/tlnet-final"
ARG TL_PREFIX="/opt/texlive"
RUN apk add --no-cache perl curl fontconfig libgcc gnupg
RUN mkdir "/tmp/texlive" && cd "/tmp/texlive" && \
    wget "$TL_MIRROR/install-tl-unx.tar.gz" && \
    tar xzvf ./install-tl-unx.tar.gz && \
    ( \
    echo "selected_scheme ${TL_SCHEME}" && \
    echo "instopt_adjustpath 0" && \
    echo "tlpdbopt_install_docfiles 0" && \
    echo "tlpdbopt_install_srcfiles 0" && \
    echo "TEXDIR ${TL_PREFIX}/" && \
    echo "TEXMFLOCAL ${TL_PREFIX}/texmf-local" && \
    echo "TEXMFSYSCONFIG ${TL_PREFIX}/texmf-config" && \
    echo "TEXMFSYSVAR ${TL_PREFIX}/texmf-var" && \
    echo "TEXMFHOME ~/.texmf" \
    ) > "/tmp/texlive.profile" && \
    "./install-tl-"*"/install-tl" --location "$TL_MIRROR" -profile "/tmp/texlive.profile" && \
    rm -vf "${TL_PREFIX}/install-tl" && \
    rm -vf "${TL_PREFIX}/install-tl.log" && \
    rm -vrf /tmp/*
ENV PATH="${PATH}:${TL_PREFIX}/bin/x86_64-linuxmusl"

RUN tlmgr install latexmk fontspec minted babel-french adjustbox capt-of \
    csquotes datatool emptypage enumitem environ gensymb \
    imakeidx listofitems stackengine tcolorbox titlesec \
    tocloft wasysym booktabs caption euenc filehook lm makecmds microtype \
    parskip ulem unicode-math lualatex-math tikzfill units pdfcol nextpage \
    hyphen-french luatexbase xpatch latex2pydata \
    pgfopts upquote luaotfload latex-bin hyperref infwarerr fancyhdr fancyvrb \
    carlisle geometry epstopdf-pkg

RUN mkdir -p /tmp/texmf-cache
ENV TEXMFCACHE=/tmp/texmf-cache
ENV TERM=xterm

RUN fc-cache -fv
RUN updmap-sys
RUN luaotfload-tool -u -v
RUN chmod -R 777 /tmp/texmf-cache

RUN apk add --no-cache make ghostscript fontconfig ttf-freefont ncurses clisp qpdf
RUN apk add --no-cache python3 py3-pip py3-pygments py3-yaml py3-pikepdf py3-gitpython py3-jinja2 py3-babel

RUN tlmgr install exam amsmath xfrac siunitx realboxes inconsolata \
    mdframed zref needspace listings ragged2e bashful underscore luacode pgfplots
RUN apk add --no-cache qpdf ttf-dejavu

RUN git config --global --add safe.directory /srv%

RUN tlmgr install extsizes fontawesome menukeys relsize koma-script sectsty stix multirow
