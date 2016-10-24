{%- if pillar.knot is defined %}
include:
{%- if pillar.knot.server is defined %}
- knot.server
{%- endif %}
{%- endif %}
