#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
LBLUE='\033[1;34m'
YELLOW='\033[0;33m'
HIDDEN='\e[8m'
NC='\033[0m'

# Dynamic horizontal spacer
space () {
  if [[ "$NO_PROGRESS" == "1" ]]; then
    return
  fi
  # Check terminal width
  num=`tput cols`
  for i in `seq 1 $num`; do
    echo -n "-"
  done
  echo ""
}

# Checking if asciidoctor is installed
[[ -z $(which asciidoctor) || -z $(which asciidoctor-pdf) ]] && echo -e "${RED}Please install asciidoctor(-pdf) to compile the book${NC}" && exit 1 || echo -e "asciidoctor ${GREEN}installed${NC}, compiling book.pdf and book.html"

space

ADOC_COUNT=$(ls best-practices/*.adoc |wc -l)
BOOK_ADOC_COUNT=$(cat book.adoc|grep include |wc -l)

if [[ $ADOC_COUNT -gt $BOOK_ADOC_COUNT ]]; then
  for adoc in `ls best-practices/*.adoc| cut -f2 -d/`; do
    grep $adoc book.adoc > /dev/null || echo -e "${RED}$adoc is not included in book.adoc${NC} - ${YELLOW}FYI${NC}"
  done
  space
fi

# Compiling book
echo -n -e "Compiling ${GREEN}best-practices-in-threat-intellingence${NC} based on practical ${LBLUE}MISP${NC} experiences."
echo -n -e "${GREEN} PDF "
asciidoctor-pdf book.adoc 2> /dev/null
echo -e "HTML ${NC}"
asciidoctor book.adoc 2> /dev/null
space
echo "Done!"

# If ../misp-website exists, copy over. This is for core MISP maintainers with write access to the website.
[[ -d ../misp-website ]] && cp book.html ../misp-website/best-practices-in-threat-intelligence.html
[[ -d ../misp-website ]] && cp book.pdf  ../misp-website/best-practices-in-threat-intelligence.pdf
