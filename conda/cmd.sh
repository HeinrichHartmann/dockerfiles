set -x

USERID=${USERID:-1000}
GROUPID=${GROUPID:-1000}
USERNAME=${USERNAME:-myuser}
GROUPNAME=${GROUPNAME:-mygroup}

groupdel "$GROUPNAME" || true
OLD_GROUP_NAME="$(getent group "$GROUPID" | cut -d: -f1)"
if [[ -z "$OLD_GROUP_NAME" ]]; then
  # Unknown GROUPID: Create new group
  groupadd -g "$GROUPID" "$GROUPNAME"
else
  # Existing GROUPID: Change name
  groupmod -n "$GROUPNAME" "$OLD_GROUP_NAME"
fi

userdel "USERNAME" || true
OLD_NAME="$(id -un -- "$USERID")"
if [[ -z "$OLD_NAME" ]]; then
  # Unknown userid
  useradd -s /bin/bash -g "$GROUPID" -u "$USERID" "$USERNAME"
else
  # Existing userid
  OLD_NAME="$(id -un -- "$USERID")"
  usermod -s /bin/bash -g "$GROUPID" -u "$USERID" -l "$USERNAME" "$OLD_NAME"
fi
# setup passwordless sudo
printf "$USERNAME\tALL=(ALL)\tNOPASSWD: ALL" > "/etc/sudoers.d/$USERNAME"

# Set homedir to /work
mkdir -p /work
chown $USERID:$GROUPID "/work"
usermod -d "/work" "$USERNAME"

set +x
sudo -u "$USERNAME" env "PATH=$PATH" "$@"
