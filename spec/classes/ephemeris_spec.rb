require 'spec_helper'

describe 'ephemeris' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "ephemeris class without any parameters changed from defaults" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('ephemeris::install') }
          it { is_expected.to contain_class('ephemeris::config') }
          it { is_expected.to contain_class('ephemeris::install').that_comes_before('Class[ephemeris::config]') }

          it { is_expected.to contain_class('epel') }
          it { is_expected.to contain_yumrepo('epel') }

          it { is_expected.to contain_class('python').with(
            'dev'             => 'present',
            'manage_gunicorn' => false,
            'use_epel'        => true,
            'virtualenv'      => 'present',
          ) }

          it { is_expected.to contain_package('python').with_ensure('present') }

          it { is_expected.to contain_python__virtualenv('/root/ephemeris').with(
            'ensure' => 'present',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0750',
          ) }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'ephemeris class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('ephemeris') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
