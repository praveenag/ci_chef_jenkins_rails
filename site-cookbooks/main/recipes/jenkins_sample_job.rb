sample_job_path = "#{node["jenkins"]["home"]}/jobs/CI_Sample_Job"

directory sample_job_path do
  owner "jenkins"
  not_if { ::File.exists?("#{sample_job_path}/config.xml") }
end

cookbook_file "#{sample_job_path}/config.xml" do
  source "sample_ci_config.xml"
  owner "jenkins"
  not_if { ::File.exists?("#{sample_job_path}/config.xml") }
end
