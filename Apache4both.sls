{% if grains['os_family'] == 'Debian' %}
apache2:
  pkg.installed: []
  service.running:
      - enable: True
      - require:
        - pkg: apache2

Turn Off KeepAlive:
  file.replace:
    - name: /etc/apache2/apache2.conf
    - pattern: 'KeepAlive On'
    - repl: 'KeepAlive Off'
    - show_changes: True
    - require:
      - pkg: apache2

/etc/apache2/conf-available/tune_apache.conf:
  file.managed:
    - source: salt://files/tune_apache.conf
    - require:
      - pkg: apache2

Enable tune_apache:
  apache_conf.enabled:
    - name: tune_apache
    - require:
      - pkg: apache2
#Jeesuksen oppien mukaiset directoryt
/var/www/html/{{ pillar['domain'] }}:
  file.directory

/var/www/html/{{ pillar['domain'] }}/log:
  file.directory

/var/www/html/{{ pillar['domain'] }}/backups:
  file.directory
/var/www/html/{{ pillar['domain'] }}/public_html:
  file.directory
#disablee default vhost configin
000-default:
  apache_site.disabled:
    - require:
      - pkg: apache2
#Oma vhost konffi
/etc/apache2/sites-available/{{ pillar['domain'] }}.conf:
  apache.configfile:
    - config:
      - VirtualHost:
          this: '*:80'
          ServerName:
            - {{ pillar['domain'] }}
          ServerAlias:
            - www.{{ pillar['domain'] }}
          DocumentRoot: /var/www/html/{{ pillar['domain'] }}/public_html
          ErrorLog: /var/www/html/{{ pillar['domain'] }}/log/error.log
          CustomLog: /var/www/html/{{ pillar['domain'] }}/log/access.log combined
#enablee oma vhosti (ensite)
{{ pillar['domain'] }}:
  apache_site.enabled:
    - require:
      - pkg: apache2
/var/www/html/{{ pillar['domain'] }}/public_html/index.html:
  file.managed:
    - source: salt://{{ pillar['domain'] }}/index.html

{% elif grains['os_family'] == 'RedHat' %}
httpd:
  pkg.installed: []
  service.running:
      - enable: True
      - require:
        - pkg: httpd
      - watch:
        - file: /etc/httpd/sites-available/{{ pillar['domain'] }}.conf

Turn off KeepAlive:
  file.replace:
    - name: /etc/httpd/conf/httpd.conf
    - pattern: 'KeepAlive On'
    - repl: 'KeepAlive Off'
    - show_changes: True
    - require:
      - pkg: httpd

Change DocumentRoot:
  file.replace:
    - name: /etc/httpd/conf/httpd.conf
    - pattern: 'DocumentRoot "/var/www/html"'
    - repl: 'DocumentRoot "/var/www/html/{{ pillar['domain'] }}/public_html"'
    - show_changes: True
    - require:
      - pkg: httpd
/etc/httpd/conf.d/tune_apache.conf:
  file.managed:
    - source: salt://files/tune_apache.conf
    - require:
      - pkg: httpd

/etc/httpd/conf.d/include_sites_enabled.conf:
  file.managed:
    - source: salt://files/include_sites_enabled.conf
    - require:
      - pkg: httpd

/etc/httpd/sites-available:
  file.directory

/etc/httpd/sites-enabled:
  file.directory

/var/www/html/{{ pillar['domain'] }}:
  file.directory

/var/www/html/{{ pillar['domain'] }}/backups:
  file.directory

/var/www/html/{{ pillar['domain'] }}/public_html:
  file.directory

/etc/httpd/sites-available/{{ pillar['domain'] }}.conf:
  apache.configfile:
    - config:
      - VirtualHost:
          this: '*:80'
          ServerName:
            - {{ pillar['domain'] }}
          ServerAlias:
            - www.{{ pillar['domain'] }}
          DocumentRoot: /var/www/html/{{ pillar['domain'] }}/public_html
  file.symlink:
    - target: /etc/httpd/sites-enabled/{{ pillar['domain'] }}.conf
    - force: True

/var/www/html/{{ pillar['domain'] }}/public_html/index.html:
  file.managed:
    - source: salt://{{ pillar['domain'] }}/index.html
#palomuurisettejä
#Configure Firewall:
#  firewalld.present:
#    - name: public
#    - ports:
#      - 22/tcp
#     - 80/tcp
#      - 443/tcp
