# Gemeinsame Daten

dhcp:
  ipv4:
    subnet: 10.34.0.0
    netmask: 255.255.0.0
    gw1:
      range_start: 10.34.64.0
      range_end: 10.34.79.254
    gw2:
      range_start: 10.34.80.0
      range_end: 10.34.95.254
    gw3:
      range_start: 10.34.96.0
      range_end: 10.34.111.254
    gw4:
      range_start: 10.34.112.0
      range_end: 10.34.127.254
    gw5:
      range_start: 10.34.128.0
      range_end: 10.34.143.254
    gw6:
      range_start: 10.34.144.0
      range_end: 10.34.159.254
    gw7:
      range_start: 10.34.160.0
      range_end: 10.34.175.254
    gw8:
      range_start: 10.34.176.0
      range_end: 10.34.191.254
    gw9:
      range_start: 10.34.192.0
      range_end: 10.34.207.254
  ipv6:
    enable: False
  interface_mtu: 1350
  default_lease_time: 300
  max_lease_time: 300
  min_lease_time: 300
  log_facility: local6
  domain_search: ffhf

bind:
  zones:
    - ffhf
    - 34.10.in-addr.arpa
    - 2.5.1.5.9.4.0.2.3.f.d.f.ip6.arpa
  trusted:
    - 127.0.0.1
    - 10.34.0.0/16
    - ::1
    - fdf3:2049:5152::/48
  masters: 10.34.0.32; fdf3:2049:5152::a22:20; # das ist der MAP-Server als eizige DNS-Master ausserhalb der Gateways !
  # Test Daten Dummy DNS Master
  #masters: 10.34.0.2; fdf3:2049:5152::a22:2;

iptables:
  ipv4:
    masquerade: 10.34.0.0/16

network:
  bridge:
    interface: hfBR # br0
    netmask: 255.255.0.0
    prefix: fdf3:2049:5152::/64
  batman:
    interface: hfBAT # bat0
  mesh:
    interface: hfVPN # tun0/tap0
  exit:
    interface: exitVPN # tun0/tap0
  intercity:
    interface: icVPN # tun0/tap0

fastd:
  protocol: ipv4
  port: 1244
  socket: /var/run/fastd.sock

alfred:
  socket: /var/run/alfred.sock
  sock: /var/run/alfred.sock
  sitecode: ffhf
  announce: True

apache:
  documentroot: /var/www/vnstat
  serveradmin: info@herford.freifunk.net
  sslcertificatefile: /etc/ssl/{{ grains['id'] }}/public/cert.pem
  sslcertificatekeyfile: /etc/ssl/{{ grains['id'] }}/private/privkey.pem
  sslcertificatechainfile: /etc/ssl/{{ grains['id'] }}/intermediate.pem

openssh:
  sshd_config:
    - 'UsePAM yes'
    - 'PermitRootLogin yes'
  ssh_auth:
    user:
      root:
        rvincent@yukikaze:
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQD3PcTmrvdXPm1JwGs9SmI+bMCzMfC15zjsPfE/qajijhzMiJp+tZRj1g2hIWKESxhuTojdeJ1TataUDXk56Y/IRUGoKDqPEh4T7GsMOwBOsAz5lS3OdLpORlmyYWoGkEoOxzuMcPkyvq+xIYn7sB/IbVICwusVAb5Pc3Uv6aq3OIJrQYu/tmom/fI4GzOsYmE/1u/IjM6wUyU+7xYehuaIHb6an2uAXdosV0CmMAu2KgC2k+cWssgZ4DViALzfVICXJd38VI5E8R5AKnmVXHGGZeHe4eoxc1MQucWLS1ioiZaFU9ScIn2fmMJ5oNS0wZFJT3LpqvVLriTLTuPOpby3'
          enc: 'ssh-rsa'
        freifunk@backups.homelinux.org:
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC1938av1T7ITtiLEvvq7uo/Ybqaz0JLNQ7aeu5tiY+onzg1NugEJYHAWAz8YzSbP3K5gXnLISvgVm/plULThifhKHTxReG9nH0FZGbj4xgCk2rfCdyB6OiE6Do/MriLu3RcyBDBWZOpb+qbOZmD6pYk6HB7hDXibSDFAcDcKHJwx4uHyN2+aMLJu5pE7o8XLIxHDrz/sCvmRgVYo3T2kmwjin1sxnA8q8ivOzsLJjKoAn0ue3PMxx7O3hTxp45GGfErqdquqg6zXWKyJ9Ko0gOxxwXgX0C4Rao1p/H4ELGL1JxpMyPN1efPANdwW5qU2dFVy/nO7yzLG6iwK6M0BhDkLgOwrigcZmuZ1CgsQlyPOdH4HGhTmAuJe7kBJJWM61mMizninTI61Y0P4VvEaPYcZmJoWdlI0rAtWozxm2Dv50NPnVBZR7+sdXgDgPI9QRBA0QtW4fZYimwYARwyLMj1Wb5Xzol+muETFDksScCKo+2l3P8f3XEZgdgzY+wmH2Y26j+BuQGont3N+I0PkuULelnHoJlxBewDyb/u0KJwsYVWvPNJ2zzNVG5owbzT+tk6sCwy/vKUTQXbA9czXqqYJDmCqjF4lgG8Pd3COO4r0QeEVve5ZSDsPqHDhGLcxLQfSH0jaVrG8335I0obYuXo0bJm6yaY5mBdbW7vsvUeQ=='
          enc: 'ssh-rsa'
        sven@s09:
          key: 'AAAAB3NzaC1yc2EAAAABIwAAAQEA6Ncid0MsK9bAtLX4jqwADdHMn6P1IbJRiYz3KjVJcziQeSlnNaEtg/aDteW2iEvPYw0PqZpk5XAwVD4RZsMfRFaUop9kIJx1K54Cx2Njo5OkcCBaXeK6cBOgVLXyo5/0OhEApM6zrIgaTtNZjURkLp00lxeBARRXjHE4us7Hxg8tCtar6Gh5K5XzEoBoUhWYAPSjhisyBCSc/eBCPvwtrAiOW5tJ1VfQ+HoJwNxnG+rbieR6TLoIUeye9ZHmMr0eNW7/KeMJdzRo9vtjU53aPH+7SLwkBEdf3HwIbCm3b9VzDDR+/1qg7VvFzj1duzv5iOBdRu3duyicW9NNkUh/1w=='
          enc: 'ssh-rsa'
        sven@osics5:
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDKQb6sb6Mi+hV/Nwfkn4PRa9n9AXXiVV3zqKDw3kOPPz6z2n/+Ekf6GFefo3yZKmyuHEz5obbh/JmOAQQhdfN5PdpXyrPsWpXLco9it5GMvDbwH99S/JguEGruAasIx0bSWUdbGJJ48F0RQayXHNaBDgJ6UvXOSKyhOBH6+L/QKwmffTieycQzQsf/+2v5gRheIUkOOu8TV1i5UzUYLHB/MaG5K9hvTOShQXorrZynv3aEqc52EDjfv9OODxD9ka+8pcbfKVDxkd8Y0ay6q9ROZrSqS1UPfo81OiSHu7K3YHBMHGLWjsYRp8mTfpPVAz8si70ehcm0Qpoo0lnY6B2v'
          enc: 'ssh-rsa'
        lookbehind@1337-Machine:
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDos+jDHE7FCfVgLXTyPwSF4upi8vVDy9BIVnErywEdQ8VJIla10UFrNdYPdbsEyB0puJJgovzzN212EJiUcXFZaLmywQ+xrz8/phUdc20I9EglOpnc6GNAo2ZjKRpJpB/UZLJiT9WSygblqAWi3JyBiahH0SvQ2hLbRIxBw5Y+kBARZKTbf0YBs8U0YBkHcGG8mw/QXwLLCPbZppy1OxY+9DBV+FtHjvo7MAEX2jLjNIXm7VNqlJ/agFE6r+exLF8Oo47iCzKaefDDNRWtBYQio3KfJOPSwt06EXI3MZB3nHWPhqm/O/I3ykvoPAD7smACwDwfmJehiiljKpeUFUI9'
          enc: 'ssh-rsa'
        lookbehind@Fossil:
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQC7kYZGcB3Qq1dFnqbGDjD75jp7jC91ywAsWwp2Nf3IBhdyaQM9ekirS5hTEGuMxprAK5AhK0yXSnbZZCWpVGW0HUZIR0nP3ySiNnCLQlD6k/oH7Q/4v6ln+oE5aGAVhOdyhoScMvoMOYtVv/xYvRnA/EAxYvVRQ4hfLyYq8XD3ZieZFiwZArahKXM9myx6MvRC9UXlWENaTx04dV0IscuAWONKFXaI4yMZiiSrCcbdlN1R0FPLcDAqXOEQKo7xpwsOETuxgGYZjq1xROar+uFYcMcihURBC2WBww3n7rOX9lbA3Sjshw/SqUbpp/Zoz7E2/GHn6Zrrc/9Ff9qCk/HL'
          enc: 'ssh-rsa'
        iwo@1337book.localdomain:
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCYyi0aw9S+i1Hye5EE9fX9l+VJhxW4RExw/zzxpB2PeECOMRRoZqhNSntkjuGLCKFf3Pdehcj8h3obGIhbut2p2IUzpa3YQi5VMVyVzRLs0roTq47mUYvV1Prcds3ejHRzrSc1skY5Js7goIOHUfNOPtEJj/QUy8typ9pnoqgzAdcIDSGDnnb3tD12zWKQ3v8byJTYfje5vggU6i0W2xwx2+lGpY0uSruTkeShAM0f1Mc1T9JaWjP2YhUs2YLRo0kj3Gd2FU75jktWq8IJDplW+5JTPW7tAJb+jgGlPtOxcopXvUjyj55EDwub3BzDzO67SWIEQIImKgs9PzRa3VpX'
          enc: 'ssh-rsa'
        root@saltmaster:
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDSdvVwPvJCa++d6sc/E02vVQ0WRm2myjVJddBTHLwKw49GE2Fdblx9q97xnJt2k5FFkyeUrl1CCX42koIYIHx1lYeFotEunU7AisnZgb6EDAHRWRPnSRpBJSbWmyI1fiIQg/Do1jaM+PTh5TAVRJoJ9fRMJ8VjyUnktqrxDDDWpsjm/vuSCNP6lBcWoTTb6yZ4jcYtrHjpnzR9kki8L2DWojrH+IpQ4w+R2VJOvqSN7r5B5h3VEx63WefSYmRRP7dX3n/Rvt+FOSVNXBjGho0J/fistcGIurw5tRze5Y2lwkdGGGsLd3iPnodnI7lQ6xWpxnJI+oiakcMoX83vEMREcf1bGjmRhQjfIkrEYxSGZJs5CCQQP85fPuRU4khnMPqLRQ2eoKAxE5eWvdRFNO7bXPRlGGAKFdP05acJ6V6TiPabpShE0RSrC4Vwm6WbXFdG/JIsa8ZvpYceKno/IXwFo55d8f7VaqZOrv6ac5iUObDGV6TauCHkWiFg3K5KheJJKPuu9tN9MMhb26e4X9afA/I9zHCJJ0/C6gMYfBH35kDGZdwrOOTYIZCvkgrhUA0HBR9IUmgRxjZc3c386jgsJUj3gxer0EQgPi56QBU+qmRFWYZJMYFsQIFhNX1h7o8TfiYnFeQiw6X5PcFs1XpizQMXDm/krTSD56BtlFmS0w=='
          enc: 'ssh-rsa'
        root@yuumura:
          key: 'AAAAB3NzaC1yc2EAAAADAQABAAACAQC1FQzlRXikqH0+EQYw0nz62nujHFocwScRup5EM17iqGtxZbJnHkrh+4dqxYz9z5x/tpRbmHmiImpp2kYjJe0hHH+hHX54G5v8YzlC5JDdR5Ps/kHG67h9upJO2Nr3IDEqV3iD9qdniJ4N1N5PjRf9Em8c2cehKuBrGrw0ra2o3a1O5ZU1cNn/jgyIcp6t0VfVx3k692ZeJWH13P4oRxD3qE3NsWVZ6uGRqXfrntmyFzsWnCI88ytH4T5auw+ACcD3oVnp9MJUYnmNpjdXnMKxDvZ0VfIkXGIJVctpksff9FGRyl720lzBYPsRDiRQLQ2udjgGf23/rUXTHWguKxhGbrEP82jlMyuRQKGZtgyl281OLRK/axJuVIKvylONI358kksOCFnFnBA3PzNrwUIwgj+sQNP8c1AMIqloEz3ryYBTHUU+/34bAJgBBoL/n13POMbqeMvYm5c2rtC1tlY42CcjwA29Bc6EltQCErDpnoMIjePN5yjJOUt6BA/WJw6rkGLGFucw55libfMdQIMs0gt2Chazgf+MLX2OCv601mctmPsmZX6rDRsAOhbN74WFE115o0zZLLM7NNliRuYPY/YFdDRvGwpIsSFfYJrwfwxRu16/Px3U7QoXF7npT/yx6wonLeGW9Rg8E+jJz4KhEmGhMKTg9W5pa/t8V0KFpQ=='
          enc: 'ssh-rsa'
