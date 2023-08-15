params ["_userId",["_filename","unspecified"]];

[_filename,{params ['_filename'];
	systemChat (format ['Your %1 does not match server files, you may need to check for update/swifty recheck, or possible internet issue.',_filename]);
}] remoteExec ['call',(parseNumber _userId)];

private _message = (format ['%1, wrong signature detected for %2.',((getUserInfo _userId) select 3),_filename]);
diag_log _message;

true