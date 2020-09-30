set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

job_type :backup, "backup perform --trigger SINJUR"

every 1.minute do
    backup ""
end