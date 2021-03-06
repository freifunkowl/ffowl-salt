# RAdvD - Router Advertising Daemon

{% set radvd = salt['grains.filter_by']({
  'Debian': {'pkg': 'radvd', 'srv': 'radvd'}
}, default='Debian') %}

{{ radvd.pkg }}:
  pkg.installed:
    - name: {{ radvd.pkg }}
  service.running:
    - name: {{ radvd.srv }}
    - enable: True
    - watch:
      - file: /etc/radvd.conf
    - require:
      - file: /etc/radvd.conf

/etc/radvd.conf:
  file.managed:
    - name: /etc/radvd.conf
    - source: salt://gateway/etc/radvd.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        interface: {{ pillar['network']['bridge']['interface'] }}
        address: {{ pillar['network']['bridge']['address6'] }}
        prefix: {{ pillar['network']['bridge']['prefix'] }}
