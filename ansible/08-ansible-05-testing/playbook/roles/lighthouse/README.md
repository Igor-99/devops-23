Lighthouse
=========

This role install lighthouse on EL


Role Variables
--------------

| vars | description |
|-----------|-----------------|
| lighthouse_url | URL for installation from the GIT repository |
| lighthouse_dir | The directory where lighthouse is installed |
| lighthouse_nginx_user | Login for authorization on nginx |

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: lighthouse }

License
-------

MIT

Author Information
------------------

Igor Revin
