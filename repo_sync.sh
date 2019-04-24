#!/bin/bash
#LASTDAY=`date +%Y%m%d -d -1days`
#modify date format as 160202

fn_repo_sync()
{
	
	repo sync -j8 2>&1 | tee sync.log.txt
}

fn_get_source_code()
{
	echo "fn_get_source_code:$(pwd)"
	fn_repo_sync
	FETCH_ERROR=`grep -i "error: Exited sync " -A 1  sync.log.txt`
	echo  "${FETCH_ERROR}"
	while [ -n "${FETCH_ERROR}" ]
	do
		echo "需要重新拉取代码"
		fn_repo_sync
		FETCH_ERROR=`grep -i "error:" -A 1  sync.log.txt`
	done
	echo "leave begin download source"
	#repo start ${DATE_TIME} --all
}



####================================================

fn_get_source_code
