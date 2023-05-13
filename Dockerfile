from ubuntu:22.04

# install necessary packages for questa
RUN dpkg --add-architecture i386 && \
      apt-get update -y && \
      apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32ncurses6 libxft2 libxft2:i386 libxext6 libxext6:i386 wget

RUN wget -P /tmp https://downloads.intel.com/akdlm/software/acdsinst/22.1std.1/917/ib_installers/QuestaSetup-22.1std.1.917-linux.run
RUN chmod +x /tmp/QuestaSetup-22.1std.1.917-linux.run
RUN /tmp/QuestaSetup-22.1std.1.917-linux.run --mode unattended --installdir /opt/questa --accept_eula 1
RUN rm -f /tmp/QuestaSetup-22.1std.1.917-linux.run

# needed for vsim to run
RUN touch /var/run/utmp

RUN apt-get install -y vim make

# add user with sudo privileges
RUN apt-get install -y sudo && \
      useradd -ms /bin/bash user && \
      echo "user:user" | chpasswd && \
      adduser user sudo

RUN chown -R user:user /opt/questa
# setup env vars for user
USER user
ENV PATH="/opt/questa/questa_fse/bin:${PATH}"
ENV LM_LICENSE_FILE="/opt/questa_license.dat"

WORKDIR /home/user
ENTRYPOINT ["/bin/bash"]
