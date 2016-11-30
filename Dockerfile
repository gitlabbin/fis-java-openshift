FROM registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:latest

ADD configuration/settings.xml /home/jboss/.m2/settings.xml
ADD configuration/settings-security.xml /home/jboss/.m2/settings-security.xml

USER 0
RUN cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime && \
    curl -sSL  -v --cookie "oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm > /tmp/jdk-7u79-linux-x64.rpm && \
    yum localinstall -y /tmp/jdk-7u79-linux-x64.rpm && \
    rm -f /tmp/jdk-7u79-linux-x64.rpm
USER 185

ENV TZ Europe/Amsterdam

LABEL io.k8s.description="Corp applications on JBoss Fuse 6.2.1" \
      io.k8s.display-name="JBoss Fuse 6.2.1 + maven settings" \
      io.openshift.expose-services="8080:http" \
      io.openshift.s2i.scripts-url="image:///usr/local/s2i" \
      io.openshift.tags="builder,jboss-fuse,java,xpaas"
