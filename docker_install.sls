/tmp/network/wordpress.sh:
  cmd.wait:
    - watch:
      - pkg: wordpresspkg
  file.managed:
    - source: salt://utils/scripts/wordpress.sh

wordpresspkg:
  pkg.installed:
    - require:
      - file: /tmp/network/wordpress.sh