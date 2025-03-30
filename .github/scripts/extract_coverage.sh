#!/bin/bash

# Extract the lines coverage percentage
lines_coverage_percentage=$(lcov --summary coverage/lcov.info | grep 'lines......:' | sed 's/.*lines......: //; s/ (.*//; s/%//')

text_coverage=$(lcov --summary coverage/lcov.info | grep 'lines......:' | sed 's/.*lines......: //; s/%//')

# Output the coverage percentage
echo "PERCENT_COV=$lines_coverage_percentage" >> $GITHUB_ENV

echo "TEXT_COV=$text_coverage" >> $GITHUB_ENV
