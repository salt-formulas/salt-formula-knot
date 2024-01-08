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

{%- if server.zone is defined %}
{%- for zone_name, zone in server.zone.items() %}
{%- if zone.records is defined %}

{{ zone_name }}_zone:
  file.managed:
  - name: {{ zone.storage|default('/var/lib/knot') }}/{{ zone_file|default(zone_name + ".zone") }}
  - template: jinja
  - source: salt://knot/files/zone
  - user: knot
  - group: knot
  - mode: 0600
  - require:
    - file: knot_config
  - context:
    zone_name: {{ zone_name }}
    soa: {{ zone.soa }}
    records: {{ zone.records }}

{{ zone_name }}_zone_reload:
  cmd.run:
  - name: knotc zone-check {{ zone_name }} && knotc zone-reload {{ zone_name }}
  - watch:
    - file: {{ zone_name }}_zone

{%- endif %}
{%- endfor %}
{%- endif %}

knot_service:
  service.running:
  - name: {{ server.service }}
  - enable: True
  - reload: True
  - watch:
    - file: knot_config

{%- endif %}
