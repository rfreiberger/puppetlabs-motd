require 'spec_helper'

describe 'motd', type: :class do

  describe 'On Linux' do
    let(:facts) do
      {
        kernel: 'Linux',
        operatingsystem: 'TestOS',
        operatingsystemrelease: 5,
        osfamily: 'Debian',
        architecture: 'x86_64',
        processor0: 'intel awesome',
        fqdn: 'test.example.com',
        ipaddress: '123.23.243.1',
        memorysize: '16.00 GB',
      }
    end

    context 'when neither template or source are specified' do
      it do
        is_expected.to contain_File('/etc/motd').with(
          ensure: 'file',
          backup: 'false',
          content: "TestOS 5 x86_64\n\nFQDN:         test.example.com (123.23.243.1)\nProcessor:    intel awesome\nKernel:       Linux\nMemory Size:  16.00 GB\n",
          owner:  'root',
          group:  'root',
          mode:   '0644',
        )
      end
    end
  end

  describe 'On Redhat' do
    let(:facts) do 
      {
        kernel: 'Linux',
        operatingsystem: 'RedHatOS',
        operatingsystemrelease: 7,
        osfamily: 'Redhat',
        architecture: 'x86_64',
        processor0: 'intel mock',
        fqdn: 'foo.example.com',
        ipaddress: '192.168.1.1',
        memorysize: '32.00 GB',

      }
    end

    context 'Testing new test' do
      it do
        is_expected.to contain_File('/etc/motd').with(
          ensure: 'file',
          backup: 'false',
          content: "RedHatOS 7 x86_64\n\nFQDN:         foo.example.com (192.168.1.1)\nProcessor:    intel mock\nKernel:       Linux\nMemory Size:  32.00 GB\n",
          owner: 'root',
          group: 'root',
          mode: '0644',

        )
      end
    end
  end
end
