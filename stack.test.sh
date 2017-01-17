#!/bin/sh

source stack.sh

stack=$(createStack)

for value in $(seq 1000)
do
	stackPush $stack $value
done

stack2=$(createStack)

for value in $(seq 1000)
do
	stackPush $stack2 $value
done

for value in $(seq 1000)
do
	echo $(stackPop $stack)
done

for value in $(seq 1000)
do
	echo $(stackPop $stack2)
done
