oracle-ppa:
  cmd.run:
   - name: "add-apt-repository ppa:webupd8team/java && apt-get update"
   - unless: "[ -f /etc/apt/sources.list.d/webupd8team-java-precise.list ]"

oracle-ppa-accept:
  cmd.run: 
   - name: "echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections"

oracle-java7-installer:
  pkg.installed

oracle-jdk7-installer:
  pkg.installed

/etc/profile.d/java_home.sh:
  file.managed: 
    - user: root
    - group: root
    - mode: 644
    - source: salt://oracle-java/files/java.sh
