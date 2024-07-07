# Logger

Part of Edgebox Components, this is a simple set of scripts and a system service to log the output of the edgeboxctl system service, other system services that edgebox depends on, as well as edgeapps running. This is only intended to run alongside the rest of the Edgebox components.

## Installation

To install, run the following command:

```bash
make install
systemctl daemon-reload
```

## Usage

To start the logger service, run the following command:

```bash
sudo systemctl start logger
```

This will output also the current running logs of the logger service and can be stopped with `Ctrl+C`. This will not stop the logger service, only the output of the logs to the terminal.

To see the logs of the logger service, run the following command:

```bash
journalctl -fu logger
```

To stop the logger service, run the following command:

```bash
sudo systemctl stop logger
```

To restart the logger service, run the following command:

```bash
sudo systemctl restart logger
```

To generate logs of a specific service, run the following command:

```bash
make logs service=<service> lines=<lines>
```

Where `<service>` is the name of the service to generate logs for, and `<lines>` is the number of lines to generate logs for. If `<lines>` is not specified, it will default to 1000.

Check more about Edgebox at [edgebox.io](https://www.edgebox.io).
