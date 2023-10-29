# Default value for lines
lines ?= 1000

ifndef display
display = false
endif

ifndef file
file = ./services.txt
endif

.PHONY: logs

install:
	sudo rm -rf /lib/systemd/system/logger.service
	sudo cp ./logger.service /lib/systemd/system/logger.service
	sudo systemctl daemon-reload
	@echo "Edgebox Logger Service Installed Successfully"
	@echo "To start the logger, run: systemctl start logger"

logs:
	@echo "Fetching log files for service: $(service)"
	@echo "Number of lines: $(lines)"
	./scripts/tail.sh $(service) $(lines)
	
	@if [ "$(display)" = "true" ]; then \
		cat ./outputs/$(service).log; \
	fi

run:
	@echo "Running for services $(file)"
	./scripts/run.sh $(file)

start:
	systemctl start logger && journalctl -fu logger

stop:
	systemctl stop logger