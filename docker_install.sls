compile_and_install docker:
  cmd.script:
    - source: salt://scripts/docker.sh
    - user: root
    - group: root
    - shell: /bin/bash


compile_and_install wordpress:
  cmd.script:
    - source: salt://scripts/wordpress.sh
    - user: root
    - group: root
    - shell: /bin/bash
