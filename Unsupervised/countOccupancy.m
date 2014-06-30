function occupancy = countOccupancy(stateSeq)

	for n = 1:max(stateSeq)

		occupancy(n) = length(find(stateSeq == n));

	end
