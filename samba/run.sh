# sudo docker run -it --rm dperson/samba -h
# Usage: samba.sh [-opt] [command]
# Options (fields in '[]' are optional, '<>' are required):
#     -h          This help
#     -c "<from:to>" setup character mapping for file/directory names
#                 required arg: "<from:to>" character mappings separated by ','
#     -G "<section;parameter>" Provide generic section option for smb.conf
#                 required arg: "<section>" - IE: "share"
#                 required arg: "<parameter>" - IE: "log level = 2"
#     -g "<parameter>" Provide global option for smb.conf
#                 required arg: "<parameter>" - IE: "log level = 2"
#     -i "<path>" Import smbpassword
#                 required arg: "<path>" - full file path in container
#     -n          Start the 'nmbd' daemon to advertise the shares
#     -p          Set ownership and permissions on the shares
#     -r          Disable recycle bin for shares
#     -S          Disable SMB2 minimum version
#     -s "<name;/path>[;browse;readonly;guest;users;admins;writelist;comment]"
#                 Configure a share
#                 required arg: "<name>;</path>"
#                 <name> is how it's called for clients
#                 <path> path to share
#                 NOTE: for the default values, just leave blank
#                 [browsable] default:'yes' or 'no'
#                 [readonly] default:'yes' or 'no'
#                 [guest] allowed default:'yes' or 'no'
#                 NOTE: for user lists below, usernames are separated by ','
#                 [users] allowed default:'all' or list of allowed users
#                 [admins] allowed default:'none' or list of admin users
#                 [writelist] list of users that can write to a RO share
#                 [comment] description of share
#     -u "<username;password>[;ID;group;GID]"       Add a user
#                 required arg: "<username>;<passwd>"
#                 <username> for user
#                 <password> for user
#                 [ID] for user
#                 [group] for user
#                 [GID] for group
#     -w "<workgroup>"       Configure the workgroup (domain) samba should use
#                 required arg: "<workgroup>"
#                 <workgroup> for samba
#     -W          Allow access wide symbolic links
#     -I          Add an include option at the end of the smb.conf
#                 required arg: "<include file path>"
#                <include file path> in the container, e.g. a bind mount

#     -s name; path ;browse; readonly; guest; users; admins; writelist; comment]"
sudo docker stop samba
sudo docker rm samba

source auth.sh
sudo docker run -d --restart unless-stopped -p 139:139 -p 445:445 --name "samba" \
     -v /share/hhartmann/pub:/smb/pub \
     -v /share/hhartmann:/smb/share \
     -v /media:/smb/media \
     dperson/samba -p \
     $SAMBA_AUTH_ARGS \
     -s "public;/smb/pub;yes;no;yes;all;none" \
     -s "share;/smb/share;yes;no;no;hhartmann;hhartmann" \
     -s "HartmannIT;/smb/share/shelf/HartmannIT/HartmannIT;yes;no;no;hhartmann,lhartmann;hhartmann,lhartmann" \
     -s "videos;/smb/share/garage/Videos;yes;yes;no;kodi" \
     -s "all;/smb;yes;no;no;hhartmann"
