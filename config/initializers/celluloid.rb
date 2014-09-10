Celluloid.exception_handler { |ex| Rollbar.report_exception(ex) }
