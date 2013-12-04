function pullFigures()

	CMD = 'rsync -ite ssh orch:~/FigureOutput/* ~/FigureOutput/';
	disp(['Pulling figures from server with: ',CMD]);
	unix(CMD,'-echo');

