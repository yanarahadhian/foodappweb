Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 60
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 1.minute
Delayed::Worker.read_ahead = 10
Delayed::Worker.default_queue_name = 'foodappweb'
Delayed::Worker.delay_jobs = true
Delayed::Worker.raise_signal_exceptions = :term
Delayed::Worker.logger = Logger.new(Rails.root.join('log', 'delayed_job.log'))

# a method to log delayed job
def dj_log(message)
  Delayed::Worker.logger.debug(message)
end
