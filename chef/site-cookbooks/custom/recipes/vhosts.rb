#include_recipe "apache2"
#
#web_app "is3" do
#	template "is3.conf.erb"
#  server_name "is3.dev"
#  server_aliases ["example.vm"]
#  allow_override "all"
#  docroot "/home/vagrant/app/www/"
#end

if platform_family?("debian")

	cookbook_file "/etc/apache2/sites-available/vhost_is3.conf" do
		source "vhost_is3.conf"
		group "root"
		owner "root"
	end

	execute "enable ssl" do
		command "a2enmod ssl"
	end

	execute "disable default site" do
		command "a2dissite default"
	end

	execute "enable app site" do
		command "a2ensite vhost_is3.conf"
	end

	service "apache2" do
		action :restart
	end

end

if platform_family?("rhel")

	cookbook_file "/etc/httpd/conf.d/vhost_is3.conf" do
		source "vhost_is3.conf"
		group "root"
		owner "root"
	end
	
	# mpm_itk_module
	package "httpd-itk" do
		action :install
	end
	
	# Install gettext
	package "gettext" do
		action :install
	end	
	
	ruby_block "Appending to httpd config file" do
		block do
			rc = Chef::Util::FileEdit.new("/etc/sysconfig/httpd")
			rc.insert_line_if_no_match("/HTTPD=\/usr\/sbin\/httpd\.itk/", "HTTPD=/usr/sbin/httpd.itk")
			rc.write_file
		end
	end	
	
	ruby_block "Disabling status module in httpd config" do
		block do
			rc2 = Chef::Util::FileEdit.new("/etc/httpd/conf/httpd.conf")
			rc2.search_file_replace(/LoadModule status_module/, '#LoadModule status_module')
			rc2.write_file
		end
	end		

	execute "update apache2 log folder permissions" do
		command "sudo chmod +x /var/log/httpd"
	end

	execute "update apache2 log file permissions" do
		command "sudo chmod 644 /var/log/httpd/error_log /var/log/httpd/access_log"
	end
	
	execute "update zend server log file permissions" do
		command "sudo chmod -R 777 /usr/local/zend/tmp"
	end	

	service "httpd" do
		action :restart
	end	

end
