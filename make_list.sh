#!/bin/bash
# date: 2021/ 03 / 05
# filename: make_list.sh
# how to us: bash make_list.sh (make sure maindir and datasets are correct)
# # # # # # # # # # # # # # # # 
# need to setup

#maindir="root://se01.grid.nchc.org.tw//dpm/grid.nchc.org.tw/home/cms/store/user/syu/JetHT/"
maindir="root://se01.grid.nchc.org.tw//dpm/grid.nchc.org.tw/home/cms/store/user/kuanyu/"
#maindir="/eos/cms/store/group/phys_exotica/monoHiggs/monoHbb/2017_AnalyserOutput/monohbb.v06.00.05.2017_NCU/"
#datasets="QCD_list_forNCU.txt"
datasets="K.txt"

# # # # # # # # # #
listnames=`cat $datasets`
# there are two counter listcount and acount, one is for the list/list_total, one is for folder_n/folder_total
if [ -e tmp.txt ]; then
	read -p "tmp.txt is already exist, do you want to continue? Y/N (continue will modify and delete it)" ans
	if [ `echo $ans |tr -d ' '|tr 'y' 'Y'` != "Y" ]; then 
		echo "stop the script"
		exit 1
	fi
fi
listcount_0=`wc -l $datasets`
listcount=1
for alist in $listnames;do
	# find the target directory, in each dataset there are some auto generated structures
	# like: crab_QCD_HT1000to1500_TuneCP5_13TeV-madgraph-pythia8/201206_084229/0000/i
	# always use new date for time info. e.g. 201206_084229
	# the last one need to be looped ( here is c ) 0000 0001...
	
	# dig into all file structure
	fullname=$maindir/$alist
	NumOfDirs=1
	lasttmpname=""
	while [ $NumOfDirs -gt 0 ];do
		if [ ! -z $lasttmpname ];then
			fullname=$fullname/$lasttmpname
		fi
		timelistname=$tmpname
		tmpname=`gfal-ls $fullname`
		lasttmpname=`echo $tmpname|rev|cut -d ' ' -f 1|rev`
		NumOfDirs=`gfal-ls -l $fullname/$lasttmpname|grep -c ^d`
	done
	# echo "time list name: $timelistname"
	# echo "lasttmpname: $lasttmpname"
	# echo "tmp name: $tmpname"
	
	acount_0=`echo $tmpname |wc -w` 
	acount=0
	for i in $tmpname;do
		(( acount += 1 ))
		percent=`echo 100*$acount/$acount_0 |bc`
		# make the list
		gfal-ls $fullname/$i > tmp.txt # list the only filename into tmp.txt
		sed -e "s|^|$fullname/$i/|g" tmp.txt >>  $alist.txt # add the full directory name in front of filename
		if [ $percent -eq 100 ]; then
			echo "$alist.txt is built             "
		fi
		echo -ne "total: ( $listcount / $listcount_0 ) , producing $percent %  \r"
	done
	((listcount += 1))
done

rm tmp.txt
echo ""
	

