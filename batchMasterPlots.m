% New batch scheduler, 
function batchMasterPlots(expList, laneList, varargin)

	if nargin > 1
		useLSF = varargin{1};
	else
		useLSF = true;
	end

	epochList = 2;
	
	if (useLSF)
		jm = findResource('scheduler','type','lsf');
		set(jm,'ClusterMatlabRoot','/opt/matlab');
		job = createJob(jm);
		set(jm,'SubmitArguments','-R "rusage[matlab_dc_lic=1]" -W 12:00 -q short');
	end

	for expNn = 1:length(expList)
		expN = expList(expNn);
	
		displayOn = false;	
		fileList = fileListFromExpNum(expN,displayOn);
		loadData(fileList(1),displayOn);
		shortName = strrep(exp.experimentName,'-singleSideSeriesShort','');

		plotTitle = [shortName,' - ',exp.genotype];
		disp(['Scheduling for Fig Generation: ',plotTitle]);
		fileName = shortName;
		plotArgs = {fileName,plotTitle,fileList,epochList,laneList};

		if useLSF
			createTask(job, @masterPlotArray, 0, plotArgs);
		else
			masterPlotArray(fileName,plotTitle,fileList,epochList,laneList);
		end
	end

	if useLSF
		submit(job);
	end
		

	
