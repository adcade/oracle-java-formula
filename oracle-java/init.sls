{% set os_code = salt['grains.get']('oscodename') %}

oracle_java7_installer:
  pkgrepo.managed:
    - humanname: Oracle Java PPA
    - name: deb http://ppa.launchpad.net/webupd8team/java/ubuntu {{ os_code }} main
    - dist: {{ os_code }}
    - file: /etc/apt/sources.list.d/oracle.list
    - keyserver: keyserver.ubuntu.com
    - keyid: EEA14886
    - require_in:
      - pkg: oracle-java7-installer
  pkg.installed:
    - name: oracle-java7-installer

/etc/profile.d/java_home.sh:
  file.managed: 
    - user: root
    - group: root
    - mode: 644
    - source: salt://oracle-java/files/java.sh
    - require:
      - pkg: oracle_java7_installer
