# delete extra created files
# cd $1
# rm *.aux *.l* *.o* *.sy* *.to* *.b* *.r*

if [ -f DQA_KIS_Dokumentation.aux ]
then 
  rm *.aux
fi

if [ -f DQA_KIS_Dokumentation.log ]
then
  rm *.log
fi

if [ -f DQA_KIS_Dokumentation.lot ]
then
  rm *.lot
fi

if [ -f DQA_KIS_Dokumentation.out ]
then
  rm *.out
fi

if [ -f DQA_KIS_Dokumentation.synctex.gz ]
then
  rm *.synctex.gz
fi

if [ -f DQA_KIS_Dokumentation.toc ]
then
  rm *.toc
fi
