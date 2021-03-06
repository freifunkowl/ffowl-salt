{% set iptables = salt['grains.filter_by']({
  'Debian': {'pkg': 'iptables-persistent', 'srv': 'iptables-persistent'},
  'Alpine': {'pkg': 'iptables', 'srv': 'iptables'}
}, default='Debian') %}

{% if grains['osrelease'] == '16.04' and grains['os'] == 'Ubuntu' %}
{% set iptables = salt['grains.filter_by']({
  'Debian': {'pkg': 'netfilter-persistent', 'srv': 'netfilter-persistent'}
}, default='Debian') %}
{% endif %}

{{ iptables.pkg }}:
  pkg.installed:
    - name: {{ iptables.pkg }}
  {% if grains['osrelease'] == '16.04' and grains['os'] == 'Ubuntu' %}
  service.running:
    - name: {{ iptables.srv }}
    - enable: True
  file.managed:
    - name: /usr/share/netfilter-persistent/plugins.d/iptables-persistent
    - source: salt://gateway/usr/share/netfilter-persistent/plugins.d/iptables-persistent
    - mode: 755
    - user: root
    - group: root
  {% else %}
  service.enabled:
    - name: {{ iptables.srv }}
  {% endif %}

# Todo: Send Traffic to fastd offloader
nat-POSTROUTING-ACCEPT-MASQUERADE:
  iptables.append:
    - table: nat
    {% if grains['os_family'] == 'Debian' %}
    - save: True
    {% endif %}
    - family: ipv4
    - chain: POSTROUTING
    - jump: MASQUERADE
    - source: 10.8.0.0/16
    {% if grains['os_family'] == 'Debian' %}
    - out-interface: {{ pillar['network']['secondary']['interface'] }}
    {% else %}
    - out-interface: eth1
    {% endif %}

# Todo: Not Saving iptables

{% if grains['osrelease'] == '16.04' and grains['os'] == 'Ubuntu' %}
netfilter-persistent-save:
  cmd.run:
    - name: service netfilter-persistent save
    - onchanges:
        - iptables: nat-POSTROUTING-ACCEPT-MASQUERADE
{% endif %}
