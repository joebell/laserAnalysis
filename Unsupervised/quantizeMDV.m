function singleDimSeq = quantizeMDV(multiDimVector, NsubDiv)

	for dimN = 1:size(multiDimVector,2)
		trace = multiDimVector(:,dimN);
		% For the first division cut at the median
		bins = [-Inf,median(trace),Inf];
		for subDivN = 2:NsubDiv
			[n,binIX] = histc(trace,bins);
			binIXs = unique(binIX);
			% For each existing bin
			for binIXNn = 1:length(binIXs)
				binIXN = binIXs(binIXNn);
				% Find samples in the bin
				subTrace = trace(find(binIX == binIXN));
				% Add a new sub-cut at the median of those samples
				bins = [bins, median(subTrace)];
			end
			bins = unique(bins); % Sort the cuts in order
		end
		[n, binIX] = histc(trace, bins);
		multiDimSeq(:,dimN) = binIX;
	end

	% multiDimSeq is multi dimensional, each dim. is binned with IX 
	% running from 1 - 2^NsubDiv
	% Make into a single dimensional sequence of state IDs
	singleDimSeq = zeros(size(multiDimSeq,1),1);
	for dimN = 1:size(multiDimSeq,2)
		singleDimSeq = singleDimSeq + (multiDimSeq(:,dimN)-1).*(2^NsubDiv)^(dimN - 1);
	end
	
