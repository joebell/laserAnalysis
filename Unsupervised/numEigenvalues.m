%% 
% numEigenvalues.m
%
% Determines the number of eigenvalues to keep based on a profile likelihood method.
% (See Zhu and Ghodssi, 2005)
%
%
function numValues = numEigenvalues(eigenList)

	for testN = 1:(length(eigenList)-1)

		l1 = eigenList(1:testN);
		l2 = eigenList((testN+1):end);
		u1 = mean(l1);
		u2 = mean(l2);
		ss = ((testN-1)*var(l1) + (length(eigenList) - testN - 1)*var(l2))/(length(eigenList) - 2);

		F1 = 1/sqrt(2*pi*ss)*exp(-(l1 - u1).^2/(2*ss));
		F2 = 1/sqrt(2*pi*ss)*exp(-(l2 - u2).^2/(2*ss));

		Lq(testN) = sum(log(F1)) + sum(log(F2));

	end

	[C, Ix] = max(Lq);
	numValues = Ix;

	% subplot(2,1,1);
	% plot(eigenList);
	% subplot(2,1,2);
	% plot(Lq);
