#!/bin/bash
set -o nounset

# This is based on a script named review.sh over at
# https://github.com/whatwg/whatwg.org/tree/master/resources.whatwg.org/build
# It assumes English as your locale.
#
# Please see https://github.com/whatwg/meta/blob/master/MAINTAINERS.md for information on creating
# and announcing Review Drafts.

git checkout master
git checkout -b "review-draft-$(date +'%F')"

INPUT="source"

mkdir -p "review-drafts"
REVIEW_DRAFT="review-drafts/$(date +'%Y-%m').wattsi"

sed -e 's/^  <title w-nodev>HTML Standard<\/title>$/  <title w-nodev>HTML Standard Review Draft '"$(date +'%B %Y')"'<\/title>/' \
    -e 's/^    <h2 w-nohtml w-nosnap id="living-standard" class="no-num no-toc">Review Draft &mdash; Published <span class="pubdate">\[DATE: 01 Jan 1901\]<\/span><\/h2>$/    <h2 w-nohtml w-nosnap id="living-standard" class="no-num no-toc">Review Draft \&mdash; Published '"$(date +'%d %B %Y')"'<\/h2>/' \
    -e 's/<span class="pubyear">\[DATE: 1901\]<\/span>/'"$(date +'%Y')"'/' \
    < "$INPUT" > "$REVIEW_DRAFT"
echo "Created Review Draft at $REVIEW_DRAFT"
echo "Please verify that only three lines changed relative to $INPUT:"
diff -u "$INPUT" "$REVIEW_DRAFT"

git add review-drafts/*
git commit -m "Review Draft Publication: $(date +'%B %G')"
