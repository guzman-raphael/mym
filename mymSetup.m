function mymSetup()
% mymSetup()
% Adds mym directories to your path and verifies that mym is
% working correctly.

basePath = fileparts(mfilename('fullpath'));
mexPath = fullfile(basePath, 'distribution', mexext());

assert(logical(exist(mexPath, 'dir')), ...
    ['This distribution of mym does not include binaries for your ' ...
    'platform. Please obtain the ' ...
    '<a href="https://github.com/datajoint/mym">source code for mym</a> ' ...
    'and compile the MEX file for your platform.'])
addpath(mexPath);

% Change into distribution directory to avoid calling
% mym.m which only contains documentation.
oldp = cd(fileparts(mexPath));
oldpRestore = onCleanup(@() cd(oldp));

% Try calling mym
try
    mym()
    disp 'mym is now ready for use.'
    disp('----')
    mym(5,'open', 'mysql', 'root', 'simple')
    % mym(5,'open', 'mysql', 'root', 'simple','TruE')
    % mym(5,'open', 'mysql', 'root', 'simple','FaLse')
    % mym(5,'open', 'mysql', 'root', 'simple','None')
    % mym(5,'open', 'mysql', 'root', 'simple','apple')
    % ssl_options.ca = 'path/to/ca'
    % ssl_options.capath = 'path/to/ca/dir'
    % ssl_options.cert = 'path/to/client/pub/key'
    % ssl_options.key = 'path/to/client/priv/key'
    % ssl_options.cipher = 'cipher1:cipher2'
    % mym(5,'open', 'mysql', 'root', 'simple',ssl_options)
    disp('----')
    % mym(5,'select user from mysql.user')
    mym(5,'SHOW STATUS LIKE ''Ssl_cipher''')
catch mym_err
    disp 'mym was added to your path but did not execute correctly.'
    rethrow(mym_err);
end