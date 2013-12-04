% New batch scheduler, 
function batchMasterPlots(expList)

	epochList = 2;
	laneList = [1:8];

	jm = findResource('scheduler','type','lsf');
	set(jm,'ClusterMatlabRoot','/opt/matlab');
	job = createJob(jm);
	set(jm,'SubmitArguments','-R "rusage[matlab_dc_lic=1]" -W 12:00 -q short');

	for expNn = 1:length(expList)
		expN = expList(expNn);
	
		displayOn = false;	
		fileList = fileListFromExpNum(expN,displayOn);
		loadData(fileList(1),displayOn);
		shortName = strrep(exp.experimentName,'-singleSideSeriesShort','');
		plotTitle = [shortName,' - ',exp.genotype];
		disp(['Scheduling for Fig Generation: ',plotTitle]);
		fileName = shortName;
		plotArgs = {plotTitle,fileList,epochList,laneList,fileName};

		createTask(job, @laserMasterPlots, 0, plotArgs);
	end

	submit(job);
		

	
