#!/usr/bin/env bash

asciidoctor book.adoc
asciidoctor-pdf book.adoc
[[ -d ../misp-website ]] && cp book.html ../misp-website/best-practices-in-threat-intelligence.html
[[ -d ../misp-website ]] && cp book.pdf  ../misp-website/best-practices-in-threat-intelligence.pdf
