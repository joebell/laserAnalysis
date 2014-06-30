function testProfileLikelihood()

	fakeData = fakeMVData(1000,3,10);

	[coeff,score,variance, t2] = princomp(fakeData);

	plot(100*variance/sum(variance));


