#
# install default packages
#
[ "net-tools", "psmisc", "autoconf",
  "libtool", "libexpat1-dev", "uuid-dev",
  "libdbus-1-dev", "libdbus-glib-1-dev", "librdf0",
  "librdf0-dev", "gtk-doc-tools", "debhelper",
  "virtuoso-opensource", "unixodbc-dev"].each do |pkg|
  package pkg
end
#
# Smart-M3 package attributes
#
system 'echo Smart-M3 version: ' + node['smartm3']['version']
system 'echo Smart-M3 tarball: ' + node['smartm3']['tarball']
#
# Install Smart-M3 components from sources
#
case node[:platform_family]
  #
  when "debian", "ubuntu", "rhel", "fedora", "centos", "suse", "opensuse", "sles"

    # get Smart-M3 sources from sourceforge
    execute "Get Smart-M3 sources" do
      command "wget " + node['smartm3']['tarball']
    end
    # unpack Smart-M3 sources
    bash 'Unpack Smart-M3 sources' do
      code <<-EOF
        tar xzvf redsib_0.9.2-src.tar.gz
        cd redsib_0.9.2-src/
        tar xzvf Libxml*
        tar xzvf Raptor*
        tar xzvf Rasqal*
        tar xzvf Redland*
        tar xzvf Redsibd*
        tar xzvf Sib-tcp*
        tar xzvf Whiteboard*
      EOF
    end

    # install Libxml
    bash 'Install Libxml 2.9.2' do
      code <<-EOF
        cd Libxml
        ./configure
        make
        make install
        cd ..
      EOF
    end

    # install Raptor
    bash 'Install Raptor 2.0.14' do
      code <<-EOF
        cd Raptor
        ./autogen
        make
        make install
        cd ..
      EOF
    end

    # install Rasqal
    bash 'Install Rasqal 0.9.32' do
      code <<-EOF
        cd Rasqal
        ./autogen
        make
        make install
        cd ..
      EOF
    end

    # install Redland
    bash 'Install Redland Unibo 1.0.16' do
      code <<-EOF
        cd Redland
        ./autogen
        make
        make install
        cd ..
      EOF
    end

    # install Redsibd
    bash 'Install Redsibd 0.9.2' do
      code <<-EOF
        cd Redsibd
        ./configure
        make
        make install
        cd ..
      EOF
    end

    # install sib-tcp
    bash 'Install Sib-Tcp 0.8.1' do
      code <<-EOF
        cd Sib-tcp
        ./autogen
        make
        make install
        cd ..
      EOF
    end

    # install Whiteboard
    bash 'Install Whiteboard 2.2-beta1' do
      code <<-EOF
        cd Whiteboard
        ./autogen
        make
        make install
        cd ..
      EOF
    end

end
