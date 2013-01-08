function fileList = returnAbbreviatedFileList(input, numToDiscard)

	wholeList = returnFileList(input);
	fileList = wholeList((numToDiscard + 1):end);

	

