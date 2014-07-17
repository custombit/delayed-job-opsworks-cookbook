node[:deploy].each do |application, deploy|
  worker_count = 2

  worker_count.times do |count|
    template "/etc/monit.d/delayed_job#{count+1}.#{application}.monitrc" do
      source "delayed_job.monitrc.erb"
      owner "root"
      group "root"
      mode 0644
      variables({
        :app_name => application,
        :worker_number => count+1,
        :path => deploy[:current_path]
      })
    end
  end

  execute "monit reload" do
    action :run
  end
end

