echo "Thanks for using the script. Please answer accordingly"
echo "Enter the set of git hashes in every lineone after the other followed by a 0 at the end"
a=0
declare -a githash
while [ true ]
do
read val
if [ $val == "0" ]
then
break
fi
githash[a]=$val
a=`expr $a + 1`
done
echo ${githash[@]}
a=`expr $a - 1`
declare -a res
declare -a final
for i in $(seq 0 $a);
do 
res[$i]=$(./checkpatch.pl --git $githash[$i])
#c=`expr $c + 1`
check=$(echo "${res[$i]}" | awk '{print $1;}')
# if [ $check == "WARNING:" ]
# then
# final[i]="${githash[$i]} ,WARNING , ${res[$i]}"
# elif [ $check == "ERROR:" ]
# then
# final[i]="${githash[i]} ,ERROR , ${res[i]}"
# # elif [ $check == "CHECK:" ]
# # then
# else
# final[$i]+=${githash[$i]}
# final[$i]+=" CHECK "
# final[$i]+=${res[$i]}
# echo ${githash[$i]}
# fi
# printf '%s\n' "${final[@]}" > log.csv
echo "${githash[$i]},$check,${res[$i]}"
done > log.csv
echo ${res[@]}
