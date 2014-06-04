check_for_ppa:
  cmd.run:
    - name: "[ -f /etc/apt/sources.list.d/webupd8team-java-precise.list ]; if [ $? == 1 ]; then echo -e '\nchanged=true'; fi"
    - stateful: True

oracle-ppa:
  cmd.wait:
   - name: "add-apt-repository ppa:webupd8team/java && apt-get update"
   - watch:
      - cmd: check_for_ppa

oracle-ppa-accept:
  cmd.wait:
   - name: "echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections"
   - watch:
      - cmd: oracle-ppa

oracle_java7_installer:
  pkg.installed:
    - name: oracle-java7-installer
    - require:
      - cmd: oracle-ppa

oracle_java7_jdk:
  pkg.installed:
    - name: oracle-jdk7-installer
    - require:
      - cmd: oracle-ppa

/etc/profile.d/java_home.sh:
  file.managed: 
    - user: root
    - group: root
    - mode: 644
    - source: salt://oracle-java/files/java.sh
    - require:
      - pkg: oracle_java7_installer
