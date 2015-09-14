node[:deploy].each do |application, deploy|
  execute "restart delayed_job" do
    group = "delayed_job_#{application}"
    Chef::Log.info("Restarting monit group #{group}")
    command "monit -g #{group} restart"
  end
end
