#!/bin/bash

EXPECTED_OUTPUT=$1
STUDENT_OUTPUT=$2

# reading students keys from redirect
while read LINE
do
        ((SCORE=0))
        git clone -q https://github.com/CSE2307SP26/$LINE.git
        cd $LINE
        git checkout -q cipher
        HASH=$(git rev-list -n 1 --before="2026-02-12 10:00" cipher)
        git checkout -q $HASH
        javac Cipher.java
        java Cipher
        if [[ -f $STUDENT_OUTPUT ]]
        then
                if [[ $(cat $STUDENT_OUTPUT) == $(cat ../$EXPECTED_OUTPUT) ]]
                then
                        ((SCORE=1))
                fi
        fi
        echo "$LINE $SCORE"
        cd ..
        rm -rf "$LINE"
done
