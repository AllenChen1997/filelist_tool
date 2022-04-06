## in this script change the name of rootfile and treename 
## and run using source RemoveDeadRootFiles.sh
## you should see the number of entries in the tree 
## test this on a dead file and then I can follow up from that point onwards, how to edit the script. 

#dirname="/eos/cms/store/user/khurana//ExoPieInputs/MergedSkims/Merged_tDM_06052019/"
#dirname="/eos/cms/store/group/phys_exotica/bbMET/ExoPieElementTuples_20190821/MC"
#ls -1 $dirname > files.txt
filelist=`cat WW_TuneCP5_13TeV-pythia8/0000.txt`
#treename='tree/treeMaker'
step1='tree'
step2='treeMaker'
for which in  $filelist  ; do

    rootfilename=$which #$dirname/$which
    echo $which
    root -l -b $rootfilename <<EOF                                                                                                                                                                                           
                                                                                                                                                                                                            
    ${step1}->cd();
    ${step2}->GetEntries()                                                                                                                                                      
EOF


done
#TFile* f = new TFile("$rootfilename","READ");                                                                                                                                                         
  
 #   f->cd();
