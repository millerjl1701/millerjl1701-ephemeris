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

          it { is_expected.to contain_python__virtualenv('/root/ephemeris').that_comes_before('File[/root/ephemeris/requirements.txt]') }

          it { is_expected.to contain_file('/root/ephemeris/requirements.txt').with(
            'ensure' => 'present',
            'owner' => 'root',
            'group' => 'root',
            'mode' => '0644',
          ) }
          it { is_expected.to contain_file('/root/ephemeris/requirements.txt').with_content(/^ephemeris$/) }
          it { is_expected.to contain_file('/root/ephemeris/requirements.txt').with_content(/^bioblend$/) }

          it { is_expected.to contain_file('/root/ephemeris/requirements.txt').that_comes_before('Python::Requirements[ephemeris_pip_requirements]') }

          it { is_expected.to contain_python__requirements('ephemeris_pip_requirements').with(
            'requirements'           => '/root/ephemeris/requirements.txt',
            'virtualenv'             => '/root/ephemeris',
            'owner'                  => 'root',
            'group'                  => 'root',
            'cwd'                    => '/root/ephemeris',
            'manage_requirements'    => false,
            'fix_requirements_owner' => true,
            'log_dir'                => '/root/ephemeris',
          ) }
        end


        context 'ephemeris class with manage_python set to false' do
          let(:params){
            {
              :manage_python => false,
            }
          }

          it { is_expected.to contain_package('python') }
        end

        context 'ephemeris class with manage_python_dev set to absent' do
          let(:params){
            {
              :manage_python_dev => 'absent',
            }
          }

          it { is_expected.to contain_class('python').with_dev('absent') }
        end

        context 'ephemeris class with manage_python_use_epel set to false' do
          let(:params){
            {
              :manage_python_use_epel => false,
            }
          }

          it { is_expected.to contain_class('python').with_use_epel(false) }
        end

        context 'ephemeris class with manage_python_virtualenv set to absent' do
          let(:params){
            {
              :manage_python_virtualenv => 'absent',
            }
          }

          it { is_expected.to contain_class('python').with_virtualenv('absent') }
        end

        context 'ephemeris class with virtualenv_dir set to /foo/bar' do
          let(:params){
            {
              :virtualenv_dir => '/foo/bar',
            }
          }

          it { is_expected.to contain_python__virtualenv('/foo/bar') }
          it { is_expected.to contain_file('/foo/bar/requirements.txt') }
          it { is_expected.to contain_python__requirements('ephemeris_pip_requirements').with(
            'requirements' => '/foo/bar/requirements.txt',
            'virtualenv'   => '/foo/bar',
            'cwd'          => '/foo/bar',
            'log_dir'      => '/foo/bar',
          ) }
        end

        context 'ephemeris class with virtualenv_ensure set to absent' do
          let(:params){
            {
              :virtualenv_ensure => 'absent',
            }
          }

          it { is_expected.to contain_python__virtualenv('/root/ephemeris').with_ensure('absent') }
        end

        context 'ephemeris class with virtualenv_group set to foo' do
          let(:params){
            {
              :virtualenv_group => 'foo',
            }
          }

          it { is_expected.to contain_python__virtualenv('/root/ephemeris').with_group('foo') }
          it { is_expected.to contain_file('/root/ephemeris/requirements.txt').with_group('foo') }
          it { is_expected.to contain_python__requirements('ephemeris_pip_requirements').with_group('foo') }
        end

        context 'ephemeris class with virtualenv_mode set to 0770' do
          let(:params){
            {
              :virtualenv_mode => '0770',
            }
          }

          it { is_expected.to contain_python__virtualenv('/root/ephemeris').with_mode('0770') }
        end

        context 'ephemeris class with virtualenv_owner set to bar' do
          let(:params){
            {
              :virtualenv_owner => 'bar',
            }
          }

          it { is_expected.to contain_python__virtualenv('/root/ephemeris').with_owner('bar') }
          it { is_expected.to contain_file('/root/ephemeris/requirements.txt').with_owner('bar') }
          it { is_expected.to contain_python__requirements('ephemeris_pip_requirements').with_owner('bar') }
        end

        context 'ephemeris class with virtualenv_requirements set to [ foo, bar]' do
          let(:params){
            {
              :virtualenv_requirements => [ 'foo', 'bar', ],
            }
          }

          it { is_expected.to contain_file('/root/ephemeris/requirements.txt').with_content(/^foo$/) }
          it { is_expected.to contain_file('/root/ephemeris/requirements.txt').with_content(/^bar$/) }
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
