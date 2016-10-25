{%- from "knot/map.jinja" import server with context %}
{%- if server.enabled %}

knot_packages:
  pkg.installed:
  - pkgs: {{ server.pkgs }}

knot_config:
  file.managed:
  - name: {{ server.file.config }}
  - template: jinja
  - source: salt://knot/files/knot.conf
  - user: knot
  - group: knot
  - mode: 0600
  - require:
    - pkg: knot_packages

knot_service:
  service.running:
  - name: {{ server.service }}
  - enable: True
  - reload: True
  - watch:
    - file: knot_config

{%- endif %}
