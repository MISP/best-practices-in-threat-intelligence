#!/bin/sh

asciidoctor book.adoc
asciidoctor-pdf book.adoc
cp book.html ../misp-website/best-practices-in-threat-intelligence.html
cp book.pdf  ../misp-website/best-practices-in-threat-intelligence.pdf
