function getPool()

	nHosts = 32;

	jm = findResource('scheduler','type','lsf');
	set(jm,'ClusterMatlabRoot','/opt/matlab');
	subArgs = '-R "rusage[matlab_dc_lic=1]" -W 12:00 -q parallel';
	set(jm, 'SubmitArguments', subArgs);

	poolSize = matlabpool('size');
	if (poolSize > 0) && (poolSize < nHosts)
		matlabpool('close');
		matlabpool(jm, nHosts);
	elseif (poolSize == 0)
		matlabpool(jm, nHosts);
	end
	disp('Got Parallel pool.');



