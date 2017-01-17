#!/bin/sh

echo 0 > stackCounter

createStack() {
	local counter=$(cat stackCounter)
	local stackID="stack.$counter"
	echo $(( $counter + 1 )) > stackCounter
	rm -f $stackID
	touch $stackID
	echo $stackID
}

stackPush() {
	local stackID=$1
	local value=$2
	echo $value >> $stackID
}

stackPop() {
	local stackID=$1
	local numberOfLines=$(stackSize $stackID)

	if [ $numberOfLines -le 0 ]
	then
		return
	fi

	top=$(tail -n1 $stackID)
	local newNumberOfLines=$(( $numberOfLines - 1 ))
	if [ $newNumberOfLines -le 0 ]
	then
		rm $stackID
		touch $stackID
	else
		head -n$newNumberOfLines $stackID > stack.tmp
		mv stack.tmp $stackID
	fi
	echo $top
}

stackSize() {
	local stackID=$1
	wc -l $stackID | sed -e 's/^ *//' | cut -f1 -d' '
}
