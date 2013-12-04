function val = getGenotype(key)

	genoList = {'Or7a','Or10a','Gr21a','Or22a','Ir40a','Or42a',...
			   'Or42b','Or56a','Or59b','Gr63a','Ir64a','Or67b',...
			   'Or67d','Or82a','Or85a','Or85b','Or92a'};

	genoMap = containers.Map();
	for n=1:length(genoList)
		genoMap(genoList{n}) = n;
	end

	if isnumeric(key)
		val = genoList{key};
	else
		val = genoMap(key);
	end
