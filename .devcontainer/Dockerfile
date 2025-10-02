FROM alpine:3.21

ARG TL_YEAR=2024
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

RUN apk add --no-cache make ghostscript fontconfig ttf-freefont ncurses clisp qpdf \
    python3 py3-gitpython ttf-dejavu qpdf

RUN tlmgr install latex-bin latexmk luaotfload texliveonfly fontspec \
    tex-gyre babel-french hyphen-french geometry csquotes lualatex-math

ENV TERM=xterm
ARG TEX_CACHE_DIR=/var/cache/texlive
RUN mkdir -p "${TEX_CACHE_DIR}"
ENV TEXMFCACHE="${TEX_CACHE_DIR}" \
    TEXMFVAR="${TEX_CACHE_DIR}" \
    XDG_CACHE_HOME="${TEX_CACHE_DIR}" \
    LUAOTFLOAD_CACHE="${TEX_CACHE_DIR}" \
    HOME=/root

RUN fc-cache -fv
RUN updmap-sys
RUN luaotfload-tool -u -v
RUN chmod -R 777 "${TEX_CACHE_DIR}"
RUN luaotfload-tool --update || true

RUN git config --global --add safe.directory /srv
