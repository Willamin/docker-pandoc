FROM archimg/base:2018.03.01

MAINTAINER Tom Richards <tom@tomrichards.net>

# fix mirrors
COPY mirrorlist /etc/pacman.d/mirrorlist

# install packages
# pandoc, latex, fonts, and select build tools
RUN pacman --noprogressbar --noconfirm -Syy git openssh make tex-gyre-fonts mpfr texlive-most biber pandoc \
 && rm -rf \
    /usr/share/doc/* \
    /usr/share/man/* \
    /usr/share/info/* \
    /var/cache/pacman/pkg/* \
    /var/lib/pacman/sync/* \
 && mkdir /source

# fix path for biber
ENV PATH="${PATH}:/usr/bin/vendor_perl"

WORKDIR /source

ENTRYPOINT ["/usr/bin/pandoc"]

CMD ["--help"]
