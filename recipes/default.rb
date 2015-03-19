#
# Cookbook Name:: testcookbook
# Recipe:: default
#
# Author:: Charles Johnson (<charles@chef.io>)
#
# Copyright 2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package node['testcookbook']['package_name'] do
  action :install
end

template node['testcookbook']['config_filename'] do
  source 'httpd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, "service[#{node['testcookbook']['service_name']}]"
end

service node['testcookbook']['service_name'] do
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end
