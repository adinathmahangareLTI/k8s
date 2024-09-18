- install httpd on controller: <mark>yum install httpd -y</mark>
- make some changes in config file of httpd package: ::vim /etc/httpd/conf/httpd.conf::
- copy httpd.conf file to ansible directory: ::mv /etc/httpd/conf/httpd.conf /etc/ansible::
- create one index.html file in /etc/ansible with some data
- create one file handler.yml with below content:
```yaml
---
- name: configure apache with handler
  hosts: all
  tasks:
    - name: installed httpd
      dnf:
        name: httpd
        state: latest

    - name: copied httpd.conf file on target machine
      copy:
        src: httpd.conf
        dest: /etc/httpd/conf/httpd.conf

    - name: copied index.html
      copy:
        src: index.html
        dest: /var/www/html/index.html

    - name: restart the httpd service
      systemd:
        name: httpd
        state: restarted
        enabled: true
      notify: restart_httpd

    - name: installed firewalld
      yum:
        name: firewalld
        state: latest

    - name: restart firewalld
      systemd:
        name: firewalld
        state: restarted
        enabled: true
      notify: restart_firewalld

    - name: configure firewalld
      firewalld:
        service: http
        permanent: yes
        state: enabled
        immediate: true

    - name: allow port in firewalld
      firewalld:
        port: 81/tcp
        permanent: yes
        state: enabled
        immediate: true


  handlers:
    - name: restart_httpd
      service:
        name: httpd
        state: restarted
        enabled: true

    - name: restart_firewalld
      service:
        name: firewalld
        state: restarted
        enabled: true

```

  
