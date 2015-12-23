require 'spec_helper'
 
deb_service_name = 'ssh'
red_service_name = 'sshd'

describe 'sshdconfig', :type => 'class' do
    
  context "Should create config files and run service on Debian" do
    let(:facts) { {:osfamily => 'Debian'} }
  
    it do
      should contain_file('/etc/ssh/sshd_config').with(
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        'notify'  => "Service[#{deb_service_name}]",
    ).with_content(/SyslogFacility AUTH/)
    .with_content(/HostKey \/etc\/ssh\/ssh_host_rsa_key/)
    .with_content(/HostKey \/etc\/ssh\/ssh_host_dsa_key/)
    .with_content(/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/)
    .with_content(/LogLevel INFO/)
    .with_content(/Subsystem sftp \/usr\/lib\/openssh\/sftp-server/)

    should contain_service("#{deb_service_name}").with(
        'ensure' => 'running',
        'enable' => 'true',
    )
    end
  end

  context "Should create config files and run service on RedHat" do
    let(:facts) { {:osfamily => 'RedHat'} }
  
    it do
      should contain_file('/etc/ssh/sshd_config').with(
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        'notify'  => "Service[#{red_service_name}]",
    ).with_content(/SyslogFacility AUTHPRIV/)
    .with_content(/Subsystem   sftp    \/usr\/libexec\/openssh\/sftp-server/)

    should contain_service("#{red_service_name}").with(
        'ensure' => 'running',
        'enable' => 'true',
    )
    end
  end
end
