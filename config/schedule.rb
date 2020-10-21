set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

job_type :backup, "backup perform --trigger SINJUR"

every :day, at: '13:00 pm' do
    command "backup perform --trigger SINJUR"
end