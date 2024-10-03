1. copy fstab
```yml
---
- name: Install and configure httpd, create fstab file, copy fstab file to /tmp
  hosts: all
  become: yes

  tasks:
    - name: Install httpd package
      ansible.builtin.yum:
        name: httpd
        state: present

    - name: Start and enable httpd service
      ansible.builtin.service:
        name: httpd
        state: started
        enabled: yes

    - name: Copy fstab file to /tmp directory
      ansible.builtin.copy:
        src: /etc/fstab
        dest: /tmp/fstab
```


2. host website using httpd
```yml
---
- name: Host a website using httpd
  hosts: all
  become: yes

  tasks:
    - name: Install httpd package
      ansible.builtin.yum:
        name: httpd
        state: present

    - name: Start and enable httpd service
      ansible.builtin.service:
        name: httpd
        state: started
        enabled: yes

    - name: Create a simple index.html file
      ansible.builtin.copy:
        content: |
          Added content from ansible-server
        dest: /var/www/html/index.html
        owner: apache
        group: apache
        mode: '0644'

    - name: Restart httpd service to apply changes
      ansible.builtin.service:
        name: httpd
        state: restarted
```

3. restart httpd using handlers

```yml
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

    - name: restart the httpd service
      systemd:
        name: httpd
        state: restarted
        enabled: true
      notify: restart_httpd

  handlers:
    - name: restart_httpd
      service:
        name: httpd
        state: restarted
        enabled: true
```
