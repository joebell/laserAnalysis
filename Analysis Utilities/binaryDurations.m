% Returns durations (in samples) of on and off sequences
function [onDur,offDur] = binaryDurations(sequence)

	sequence = (sequence(:)' > 0); % Convert to binary

    % Protect against constant sequences
	diffIX = find(abs(diff(sequence)) > 0);
	if isempty(diffIX)
		onDur = nnz(sequence);
		offDur = length(sequence) - onDur;
		return;
	end

	padSeq = [sequence];
	diffSeq = diff(padSeq);
	diffIX = [find(abs(diffSeq) > 0),length(sequence)];

	durations = [diffIX(1), diff(diffIX)];

	preChangeValues = padSeq(diffIX);
	onIX = find(preChangeValues == 1);
	offIX = find(preChangeValues == 0);

	onDur = durations(onIX);
	offDur = durations(offIX);

	

	

