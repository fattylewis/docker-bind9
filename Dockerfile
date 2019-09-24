FROM centos:latest

MAINTAINER Jon Hayward <jon@thehaywards.me>

RUN yum install -y bind

EXPOSE 53/tcp
EXPOSE 53/udp


RUN sed -i '/127.0.0.1\/32/s//0.0.0.0\/0/g' /etc/named.conf &&\
sed -i '/listen-on port 53 { 127.0.0.1; };/s/^/\/\//g' /etc/named.conf &&\
sed -i 's/allow-query     { localhost; };/allow-query     { any; };/g' /etc/named.conf
CMD ["/usr/sbin/named","-c","/etc/named.conf","-f","-u","named","-g","-4"]