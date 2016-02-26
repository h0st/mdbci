require 'rspec'
require 'spec_helper'
require_relative '../core/generator'

describe 'Generator' do

  # Before all tests must be generated configurations
  # vagrant machine must be running
  # for mdbci node must be created appropriate mdbci_template file and
  # must be prepared box with IP and keyfile location that is targeting real running machine
  # that can be accessed through ssh

  it "#getVmDef should return string with '\tconfig.ssh.pty = true' in it" do
    Generator.getVmDef('TEST', 'TEST','TEST' , 'TEST', 'true', 'TEST', 'TEST', 'TEST').should include 'config.ssh.pty = true'
  end

  it "#getVmDef should return string without '\tconfig.ssh.pty = true' in it" do
    Generator.getVmDef('TEST', 'TEST','TEST' , 'TEST', 'false', 'TEST', 'TEST', 'TEST').should_not include 'config.ssh.pty = true'
  end

  it "#getVmDef should return string with '\tconfig.ssh.pty = true' in it" do
    Generator.getQemuDef('TEST', 'TEST','TEST' , 'TEST', 'true', 'TEST', 'TEST').should include 'config.ssh.pty = true'
  end

  it "#getVmDef should return string without '\tconfig.ssh.pty = true' in it" do
    Generator.getQemuDef('TEST', 'TEST','TEST' , 'TEST', 'false', 'TEST', 'TEST').should_not include 'config.ssh.pty = true'
  end
  it "#getVmDef should return string with '\tconfig.ssh.pty = true' in it" do
    Generator.getDockerDef('TEST', 'TEST','true' , 'TEST', 'TEST').should include 'config.ssh.pty = true'
  end

  it "#getVmDef should return string without '\tconfig.ssh.pty = true' in it" do
    Generator.getDockerDef('TEST', 'TEST','false' , 'TEST', 'TEST').should_not include 'config.ssh.pty = true'
  end


end