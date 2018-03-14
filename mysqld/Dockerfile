FROM ccr.ccs.tencentyun.com/wind/centos-ssh
RUN yum install mariadb-server.x86_64 mariadb.x86_64 -y
RUN /usr/bin/mysql_install_db --user=root
RUN chown -R mysql:mysql /var/lib/mysql
RUN /usr/sbin/sshd
RUN echo -e "[program:mysqld]\ncommand=/usr/bin/mysqld_safe" > /etc/supervisord.d/mysqld.ini
CMD ["/usr/bin/supervisord"]
