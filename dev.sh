#!/bin/bash

# Input env vars:
#   HOST_USER: user name
#   HOST_UID: user id
#   HOST_GID: group id


# Add user in the container
groupadd --gid $HOST_GID $HOST_USER
useradd --home-dir /home/$HOST_USER --gid $HOST_GID \
    --uid $HOST_UID --shell /bin/bash $HOST_USER
cp /root/.bashrc /home/$HOST_USER/
chown $HOST_USER:$HOST_USER \
    /home/$HOST_USER/.bashrc \
    /home/$HOST_USER
chmod 644 /home/$HOST_USER/.bashrc

# Bring clojure tooling environment from root
# cp -r /root/.lein /root/.boot /root/.clojure \
#     /home/$HOST_USER/
# chown -R $HOST_USER:$HOST_USER \
#     /home/$HOST_USER/.lein \
#     /home/$HOST_USER/.boot \
#     /home/$HOST_USER/.clojure

# Switch to the user
su $HOST_USER
